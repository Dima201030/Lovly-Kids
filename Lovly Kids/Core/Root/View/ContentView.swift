//
//  ContentView.swift
//  Manager
//
//  Created by Дима Кожемякин on 23.02.2024.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @StateObject private var viewModelSessions = SessionsViewModel()
    @StateObject private var viewModel = ContentViewModel()
    @EnvironmentObject private var appData: AppData
    
    @State private var isVerified = false
    
    var body: some View {
        VStack {
            Group {
                if viewModel.userSession != nil {
                    TabView {
                        MainView()
                            .tabItem {
                                Label("Main",
                                      systemImage: "house")
                            }
                        
                        InboxView()
                            .tabItem {
                                Label("Messenger",
                                      systemImage: "message"
                                )
                            }
                        
                        NavigationView {
                            if #available(iOS 17, *) {
                                SettingsView()
                            }
                        }
                        .tabItem {
                            Label("Settings",
                                  systemImage: "gear")
                        }
                    }
                } else {
                    LoginView()
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
//        .sheet(isPresented: $isVerified) {
////            Verefi()
////            .interactiveDismissDisabled(true)
//        }
//        .onAppear {
//            checkVerificationStatus()
////            checkForBlock()
//        }
    }
    func checkVerificationStatus() {
        Auth.auth().currentUser?.reload(completion: { error in
            if let user = Auth.auth().currentUser {
                if user.isEmailVerified {
                } else {
                    isVerified.toggle()
                }
            }
        })
    }
//    private func checkForBlock() {
//        if isBlocked() {
//            AuthService.shared.singOut()
//        }
//    }
//    
//    private func isBlocked() -> Bool {
//        false
//    }
}
