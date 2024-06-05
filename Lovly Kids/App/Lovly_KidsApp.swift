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
    @EnvironmentObject private var viewModelChat: ChatViewModel
    
    private let appData = AppData()
    init() {
        try? Tips.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .task {
                    if shouldResetTips {
                        try? Tips.resetDatastore()
                        try? Tips.showAllTipsForTesting()
                    }
                    
                    
                    try? Tips.configure([
                        .displayFrequency(.immediate),
                        .datastoreLocation(.applicationDefault)
                    ])
                }
                .environment(\.locale, appData.language)
                .environmentObject(appData)
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
        
        let appData = AppData()
        let contentView = ContentView().environmentObject(appData)
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}
