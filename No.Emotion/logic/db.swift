//
//  db.swift
//  No.Emotion
//
//  Created by Michael Safir on 31.10.2021.
//

import Foundation
import SwiftUI
import RealmSwift


var RealmAPI: RealmDB = RealmDB()

class RealmDB: ObservableObject, Identifiable {
    var id: Int = 0
    @ObservedObject var logic: Logic = LogicAPI
    
    let realm : Realm
    init() {
        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: 1,
            
            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: { migration, oldSchemaVersion in
                // We haven’t migrated anything yet, so oldSchemaVersion == 0
                if (oldSchemaVersion < 1) {
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
    
}
