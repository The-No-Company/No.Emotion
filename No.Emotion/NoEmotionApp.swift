//
//  No_EmotionApp.swift
//  No.Emotion
//
//  Created by Michael Safir on 31.10.2021.
//

import SwiftUI
import UIKit
import YandexMobileMetrica

@main
struct NoEmotionApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            Start()
        }
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        let configuration = YMMYandexMetricaConfiguration.init(apiKey: "b9530fb5-b0c0-4ddd-beb5-05c09700aeb4")
        YMMYandexMetrica.activate(with: configuration!)
        
        RealmAPI.synciCloud()
        return true
    }
    
}
