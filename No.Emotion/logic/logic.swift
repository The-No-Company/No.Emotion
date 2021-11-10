//
//  logic.swift
//  No.Emotion
//
//  Created by Michael Safir on 31.10.2021.
//

import Foundation
import SwiftUI
import Alamofire
import SwiftyJSON

var LogicAPI: Logic = Logic()
fileprivate let separator = "\u{FFFF}"


class Logic: ObservableObject, Identifiable {
    public var id: Int = 0
    
    //  Usable arrays
    @Published var emotions : [Emotion] = []
    @Published var monthColors : [Color] = []
    @Published var news : [News] = []
    
    @Published var smiles = ["😀","😌","😒","😤","😡","😭","😰","🤧","😵","😎","🥳","🥺","😂","🥰","🤪","😬","🤢","🤝","🙏","😞","😴","🤑","😩","🤩"]
    @Published var add : Bool = false
    
    @ObservedObject var network: Network = Network()
    
    public struct Emotion: Identifiable, Hashable{
        var id : Int = 0
        var bright : Float = 0
        var date : Date = Date()
        var tags : [String] = []
    }
    
    
    public struct News: Identifiable, Hashable{
        var id : Int = 0
        var title : String = ""
        var author : String = ""
        var image : String = ""
    }
    
    //    Logic data
    func getSmileColor(smile: String) -> Color{
        
        switch smile {
        case "😀":
            return .green
        case "😌":
            return .green
        case "😒":
            return .orange
        case "😤":
            return .orange
        case "😡":
            return .red
        case "😭":
            return .red
        case "😰":
            return .red
        case "🤧":
            return .orange
        case "😵":
            return .orange
        case "😎":
            return .green
        case "🥳":
            return .green
        case "🥺":
            return .orange
        case "😂":
            return .green
        case "🥰":
            return .green
        case "🤪":
            return .green
        case "😬":
            return .orange
        case "🤢":
            return .red
        case "🤝":
            return .green
        case "🙏":
            return .orange
        case "😞":
            return .orange
        case "😴":
            return .orange
        case "🤑":
            return .green
        case "😩":
            return .orange
        case "🤩":
            return .green
        default:
            return .clear
        }
        
        
    }
    
    func extractTags(tags: String) -> [String]{
        return tags.components(separatedBy: separator)
    }
    
    func impactTags(tags: [String]) -> String{
        return tags.joined(separator: separator)
    }
    
    func getTodayNews(completionHandler: @escaping (_ success:Bool) -> Void){
        AF.request("https://service.api.thenoco.co/noemotion/all", method: .get).responseJSON { (response) in
            if (response.value != nil) {
                let json = JSON(response.value!)
                let json_string_cache = json.rawString()
                if (json.count > 0) {
                    self.news.removeAll()
                    for i in 0...json.count - 1 {
                        let object = json[i]
                        withAnimation{
                            self.news.append(News(id: object["id"].int!, title: object["title"].string!, author: object["subtitle"].string!, image: object["img"].string!))
                        }
                    }
                    
                    DispatchQueue.main.async {
                        completionHandler(true)
                    }
                }else{
                    completionHandler(false)
                }
            }else{
                completionHandler(false)
            }
        }
    }
    
    func getEmotions(){
        RealmAPI.getEmotions()
    }
    
    func impactLine(){
        let format : String = "MM.yyyy"
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        self.monthColors.removeAll()
        
        for emotion in emotions {
            if (formatter.string(from: Date()) == formatter.string(from: emotion.date)){
                for tag in emotion.tags{
                    self.monthColors.append(self.getSmileColor(smile: tag).opacity(Double(emotion.bright)/100))
                }
            }
        }
        
    }
    
    func addEmotion(emotion: Emotion){
        
        let formatter = DateFormatter()
        formatter.locale =  Locale(identifier: "ru_RU")
        formatter.dateFormat = "dd.MM.yyyy.HH.mm.ss"
        
        let id =  Int(formatter.string(from: emotion.date).replacingOccurrences(of: ".", with: "", options: .literal, range: nil))!
        
        RealmAPI.setEmotion(id: id,
                            tags: self.impactTags(tags: emotion.tags),
                            date: emotion.date,
                            bright: emotion.bright)
        
    }
    
    func deleteEmotion(id: Int){
        RealmAPI.deleteEmotion(id: id)
    }
}

class Network: ObservableObject, Identifiable {
    public var id: Int = 0
    
}
