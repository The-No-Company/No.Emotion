//
//  db.swift
//  No.Emotion
//
//  Created by Michael Safir on 31.10.2021.
//

import Foundation
import SwiftUI
import RealmSwift
import IceCream
import CloudKit

var RealmAPI: RealmDB = RealmDB()

class RealmDB: ObservableObject, Identifiable {
    var id: Int = 0
    @ObservedObject var logic: Logic = LogicAPI
    var syncEngine: SyncEngine?
    
    let realm : Realm
    init() {
        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: 3,
            
            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: { migration, oldSchemaVersion in
                // We haven’t migrated anything yet, so oldSchemaVersion == 0
                if (oldSchemaVersion < 3) {
                    // Nothing to do!
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
                }
            })
        
        // Tell Realm to use this new configuration object for the default Realm
        Realm.Configuration.defaultConfiguration = config
        
        // Now that we've told Realm how to handle the schema change, opening the file
        // will automatically perform the migration
        realm = try! Realm()
    }
    
    
    func delete(){
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    func deleteEmotion(id: Int) {
        let realm = try! Realm()
        let object = realm.objects(Emotion.self).filter("id = \(id)")
        try! realm.write {
            realm.delete(object)
        }
        self.getEmotions()
    }
    
    func getEmotions(){
        let realm = try! Realm()
        let objects = realm.objects(Emotion.self)
        
        if (objects.count > 0) {
            LogicAPI.emotions.removeAll()
            for i in 0...objects.count - 1 {
                let current = objects[i]
                LogicAPI.emotions.append(Logic.Emotion(id: current.id,
                                                       bright: current.bright,
                                                       date: current.date,
                                                       tags: LogicAPI.extractTags(tags: current.tags)
                                                      ))
            }
            
            LogicAPI.objectWillChange.send()
            LogicAPI.impactLine()
        }
    }
    
    func setEmotion(id: Int, tags: String, date: Date, bright: Float){
        
        let emotion = Emotion()
        emotion.date = date
        emotion.bright = bright
        emotion.tags = tags
        emotion.id = id
        
        try! realm.write {
            realm.add(emotion)
        }
        
        self.getEmotions()
        
    }
    
    func synciCloud(){
        syncEngine = SyncEngine(objects: [
            SyncObject(type: Emotion.self)
        ])
    }
    
    
}

open class Emotion: Object {
    @objc dynamic var id = 0
    @objc dynamic var tags : String = ""
    @objc dynamic var bright :  Float = 0
    @objc dynamic var date: Date = Date()
    
    open override class func primaryKey() -> String? {
        return "id"
    }
}



extension Emotion: CKRecordConvertible & CKRecordRecoverable {
    public var isDeleted: Bool {
        false
    }
}

