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
        .sheet(isPresented: $isVerified) {
            Verefi()
            .interactiveDismissDisabled(true)
        }
        .onAppear {
            checkVerificationStatus()
            checkForBlock()
        }
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
    // Проверка на блокировку
    private func checkForBlock() {
        // Проверяем, заблокирован ли пользователь
        if isBlocked() {
            // Если заблокирован, то вызываем signOut()
            AuthService.shared.singOut()
        }
    }
    
    // Пример функции проверки на блокировку (здесь может быть ваша реализация)
    private func isBlocked() -> Bool {
        //        viewModelSessions.sessions[0].id
        false // Заглушка, замените на вашу реализацию
    }
}
