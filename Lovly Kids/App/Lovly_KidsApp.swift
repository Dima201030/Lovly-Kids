//
//  Lovely_KidsApp.swift
//  Lovely_Kids
//
//  Created by Дима Кожемякин on 23.02.2024.
//

import SwiftUI
import FirebaseCore

@main
struct YourApp: App {
    // Register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var delegate
    @EnvironmentObject private var viewModelChat: ChatViewModel

    // Create an instance of AppData
    private let appData = AppData()
    
    var body: some Scene {
        WindowGroup {
            // Pass the appData instance to ContentView
            ContentView()
                .environment(\.locale, appData.language)
                .environmentObject(appData)
                .environment(\.colorScheme, .light)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        // Создание экземпляра AppData
        let appData = AppData()
        
        // Создание корневого представления
        let contentView = ContentView().environmentObject(appData)

        // Инициализация окна
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}
