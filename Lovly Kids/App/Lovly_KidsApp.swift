//
//  Lovely_KidsApp.swift
//  Lovely_Kids
//
//  Created by Дима Кожемякин on 23.02.2024.
//

import SwiftUI
import FirebaseCore
import UIKit
import TipKit

@main
struct LovelyKids: App {
    @AppStorage("shouldResetTips")
    var shouldResetTips: Bool = true
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var delegate
    
    private let appData = AppData()
    private let viewModelUserProfile = UserProfileViewModel()
    private let viewModelLogin = LoginViewModel()
    
    init() {
        if #available(iOS 17, *) {
            try? Tips.configure()
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .task {
                    if shouldResetTips {
                        if #available(iOS 17, *) {
                            try? Tips.resetDatastore()
                            Tips.showAllTipsForTesting()
                        }
                    }
                    if #available(iOS 17, *) {
                        try? Tips.configure([
                            .displayFrequency(.immediate),
                            .datastoreLocation(.applicationDefault)
                        ])
                    }
                }
                .environmentObject(viewModelUserProfile)
                .environmentObject(appData)
                .environmentObject(viewModelLogin)
                .environment(\.locale, appData.language)
        }
    }
}

//@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        requestPushNotificationAuthorization()
        return true
    }
    
    func requestPushNotificationAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Push notification authorization granted")
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            } else {
                print("Push notification authorization denied")
            }
        }
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // Pass device token to Firebase for authentication
//        Auth.auth().setAPNSToken(deviceToken, type: .prod)
        #warning("HERE")
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register for remote notifications:", error.localizedDescription)
    }
    
    // Handle remote notifications received while app is running
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        // Handle the notification
        print("Received remote notification while app is running:", userInfo)
    }
    
    // Handle remote notifications for iOS 10 and earlier
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // Handle the notification
        print("Received remote notification on iOS 10 or earlier:", userInfo)
        completionHandler(.newData)
    }
}

//class AppDelegate: NSObject, UIApplicationDelegate {
//    func application(_ application: UIApplication,
//                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        FirebaseApp.configure()
//        return true
//    }
//}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        let appData = AppData()
        let viewModelUserProfile = UserProfileViewModel()
        let viewModelLogin = LoginViewModel()
        
        let contentView = ContentView()
            .environmentObject(appData)
            .environmentObject(viewModelUserProfile)
            .environmentObject(viewModelLogin)
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}
