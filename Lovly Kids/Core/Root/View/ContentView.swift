//
//  ContentView.swift
//  Manager
//
//  Created by Дима Кожемякин on 23.02.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    @EnvironmentObject var appData: AppData
    var body: some View {
            VStack {
                Group {
                    if viewModel.userSession != nil {
                        TabView {
                            Text("Main view")
                                .tabItem {
                                    Label("Main",
                                          systemImage: "house")
                                }
                            InboxView()
                                .tabItem {
                                    Label("Messanger",
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
    }
}

#Preview {
    ContentView()
        .environmentObject(AppData())
}
