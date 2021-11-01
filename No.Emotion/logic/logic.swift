//
//  logic.swift
//  No.Emotion
//
//  Created by Michael Safir on 31.10.2021.
//

import Foundation
import SwiftUI

var LogicAPI: Logic = Logic()

class Logic: ObservableObject, Identifiable {
    public var id: Int = 0
    
//  Usable arrays
    @Published var emotions : [DayEmotion] = []
    @Published var monthColors : [Color] = []
    @Published var news : [News] = []
    
    @Published var smiles = ["😀","😌","😒","😤","😡","😭","😰","🤧","😵","😎","🥳","🥺"]
    @Published var add : Bool = false
    
    @ObservedObject var network: Network = Network()
        
    public struct Emotion: Identifiable, Hashable{
        var id : Int = 0
        var title : String = ""
        var colors : [Color] = []
    }
    
    public struct DayEmotion: Identifiable, Hashable{
        var id : Int = 0
        var date : Date = Date()
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
            return .purple
        case "🥺":
            return .pink
        default:
            return .clear
        }
        
        return .clear
    }
    
    func getTodayNews(){
        
    }
    
    func getEmotions(){
        
    }
    
    func addEmotion(emotion: Emotion){
        
    }
    
    func deleteEmotion(id: Int){
        
    }
}

class Network: ObservableObject, Identifiable {
    public var id: Int = 0
    
}
