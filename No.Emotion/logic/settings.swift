//
//  settings.swift
//  No.Emotion
//
//  Created by Michael Safir on 31.10.2021.
//

import Foundation
import SwiftUI
import UIKit

func alert(title: String, message: String){
    UIApplication.shared.windows.first?.rootViewController?.present(alertView(title: title, message: message), animated: true)
}

private func alertView(title: String, message: String) -> UIAlertController {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

    let okAction = UIAlertAction (title: "Okey", style: UIAlertAction.Style.cancel, handler: nil)
    alert.addAction(okAction)
    
    return alert

}


func openSettings(title: String, message: String) {
    UIApplication.shared.windows.last?.rootViewController?.present(alertViewSettingsOpen(title: title, message: message), animated: true)
}

private func alertViewSettingsOpen(title: String, message: String) -> UIAlertController {
    
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

    let okAction = UIAlertAction (title: "Close", style: UIAlertAction.Style.cancel, handler: nil)
    alert.addAction(okAction)
    
    let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                   return
               }

               if UIApplication.shared.canOpenURL(settingsUrl) {
                   UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                       print("Settings opened: \(success)") // Prints true
                   })
               }
           }

    alert.addAction(settingsAction)
    return alert

}


var SettingsAPI: Settings = Settings()

class Settings: ObservableObject, Identifiable {
    public var id: Int = 0
    
    func setupPushNotifications() {
        UIApplication.shared.applicationIconBadgeNumber = 0
        requestPushNotificationsPermissions()
    }
    
    private func requestPushNotificationsPermissions() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if !granted || error != nil {
            } else {
                UserDefaults.standard.set(false, forKey: "didSetupPushNotifications")
                let center = UNUserNotificationCenter.current()
                center.removeAllDeliveredNotifications()
                center.removeAllPendingNotificationRequests()
                self.schedulePushNotifications()
            }
        }
    }
    
    private func schedulePushNotifications() {
        if UserDefaults.standard.bool(forKey: "didSetupPushNotifications") { return }
        PushNotification.allCases.forEach { (push) in
            let content = UNMutableNotificationContent()
            content.title = "No.Emotion"
            content.body = push.rawValue
            content.sound = .default
            let trigger = UNCalendarNotificationTrigger(dateMatching: push.time, repeats: true)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request) { error in
                if let errorMessage = error?.localizedDescription {
                    print("NOTIFICATION ERROR: \(errorMessage)")
                } else {
                    UserDefaults.standard.set(true, forKey: "didSetupPushNotifications")
                    UserDefaults.standard.synchronize()
                }
            }
        }
    }
    
}


enum PushNotification: String, CaseIterable {
    case morning = "Good morning, how are you feeling?"
    case noon = "How is your day going? Write down new emotions."
    case evening = "How was your day? Tell us, please."
    
    /// Hour of the day set in 24hours format
    var time: DateComponents {
        var components = DateComponents()
        switch self {
        case .morning:
            components.hour = 11
        case .noon:
            components.hour = 14
        case .evening:
            components.hour = 21
        }
        return components
    }
}
