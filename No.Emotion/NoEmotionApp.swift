import SwiftUI
import UIKit
import YandexMobileMetrica

@main
struct NoEmotionApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @ObservedObject var logic: Logic = LogicAPI

    var body: some Scene {
        WindowGroup {
            VStack {
                if self.logic.welcome {
                    Start()
                        .transition(.opacity)
                } else {
                    onboardingView()
                        .transition(.opacity)
                        .preferredColorScheme(.dark)
                }
            }.onAppear {
                self.logic.welcomeCI()
                print(UserDefaults.standard.bool(forKey: "onboarding"))
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    @ObservedObject var logic: Logic = LogicAPI

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        let configuration = YMMYandexMetricaConfiguration(apiKey: "b9530fb5-b0c0-4ddd-beb5-05c09700aeb4")
        YMMYandexMetrica.activate(with: configuration!)

        if UserDefaults.standard.bool(forKey: "icloud") {
            RealmAPI.synciCloud()
        }

        return true
    }
}
