//
//  settingsView.swift
//  No.Emotion
//
//  Created by Michael Safir on 31.10.2021.
//

import Foundation
import SwiftUI


struct settingsView: View {
    
    @ObservedObject var logic: Logic = LogicAPI
    
    var body: some View {
        VStack{
            Text("Settings")
        }
    }
}

