//
//  ContentView.swift
//  Manager
//
//  Created by Дима Кожемякин on 23.02.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModelSessions = SessionsViewModel()
    @StateObject var viewModel = ContentViewModel()
    @EnvironmentObject var appData: AppData
    
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
                        NavigationStack {
                            SettingsView()
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
        .onAppear {
            // Проверка на блокировку при появлении ContentView
            checkForBlock()
        }
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
        return false // Заглушка, замените на вашу реализацию
    }
}
