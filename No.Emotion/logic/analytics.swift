import Alamofire
import Foundation
import SwiftUI
import SwiftyJSON

var AnalyticsAPI = Analytics()

class Analytics: ObservableObject, Identifiable {
    public var id = 0
    private var server = "https://service.api.thenoco.co/analytics/"
    public var application = "no.emotion"
    public var user = ""

    public func send(action: String) {
        if user != "" {
            AF.request("\(server)add", method: .post,
                       parameters: ["user_id": user, "action": action, "app": application]).responseJSON { response in
                if response.response?.statusCode == 200 {
                    print("logs send success")
                } else {
                    print("logs send error with code: \(String(describing: response.response?.statusCode))")
                }
            }
        }
    }

    public func register() {
        if UserDefaults.standard.bool(forKey: "register") {
            let userDefaults = UserDefaults.standard.string(forKey: "user") ?? ""
            if userDefaults == "" {
                print("error while user registration")
            } else {
                user = userDefaults
            }
            return
        }

        UserDefaults.standard.set(true, forKey: "icloud")
        UserDefaults.standard.set(true, forKey: "haptic")
        UserDefaults.standard.set(true, forKey: "notifications")

        AF.request("\(server)register", method: .get, parameters: ["app": application]).responseJSON { response in
            if response.value != nil {
                let json = JSON(response.value!)
                let user = json["user"].string!

                self.user = user
                UserDefaults.standard.set(user, forKey: "user")
                UserDefaults.standard.set(true, forKey: "register")

                self.send(action: "registration")

                print("user registration success \(self.user)")
            }
        }
    }
}
