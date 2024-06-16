//
//  SettingsView.swift
//  Lovly Kids
//
//  Created by Дима Кожемякин on 29.02.2024.
//

import SwiftUI
import TipKit

@available(iOS 16, *)
struct SettingsView16: View {
    @StateObject private var viewModel = InboxViewModel()
    @EnvironmentObject private var appData: AppData
    @State private var isTipVisible = true
    
    private var user: User? {
        viewModel.currentUser
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("F9F6F1")
                
                List {
                    if let user {
                        Section {
                            if #available(iOS 17, *){
                                NavigationLink(destination: ProfileView(user: user)) {
                                    HStack {
                                        ZStack {
                                            Color.blue
                                                .cornerRadius(10)
                                                .frame(width: 30, height: 30)
                                            
                                            Image(systemName: "person.text.rectangle.fill")
                                                .foregroundColor(.white)
                                        }
                                        
                                        Text("Profile")
                                    }
                                }
                            } else if #available(iOS 15.0, *){
                                NavigationLink(destination: ProfileView15(user: user)) {
                                    HStack {
                                        ZStack {
                                            Color.blue
                                                .cornerRadius(10)
                                                .frame(width: 30, height: 30)
                                            
                                            Image(systemName: "person.text.rectangle.fill")
                                                .foregroundColor(.white)
                                        }
                                        
                                        Text("Profile")
                                    }
                                }
                            }
                        }
                    }
                    
                    Section {
                        ForEach(SettingsOptionsViewModel.allCases, id: \.self) { option in
                            NavigationLink(destination: option.destinationView) {
                                HStack {
                                    ZStack {
                                        option.backgroundColor
                                            .cornerRadius(10)
                                            .frame(width: 30, height: 30)
                                        
                                        Image(systemName: option.icon)
                                            .foregroundColor(.white)
                                    }
                                    
                                    option.title
                                        .font(.subheadline)
                                }
                            }
                        }
                    }
                    
                    Section {
                        NavigationLink {
                            SessionsView()
                        } label: {
                            HStack {
                                ZStack {
                                    Color.gray
                                        .cornerRadius(10)
                                        .frame(width: 30, height: 30)
                                    
                                    Image(systemName: "macbook.and.iphone")
                                        .foregroundColor(.white)
                                }
                                
                                Text("Devices")
                            }
                        }
                    }
                    
                    Section {
                        NavigationLink {
                            EmptyView()
                        } label: {
                            HStack {
                                ZStack {
                                    Color.orange
                                        .cornerRadius(10)
                                        .frame(width: 30, height: 30)
                                    
                                    Image(systemName: "ellipsis.bubble.fill")
                                        .foregroundColor(.white)
                                }
                                Text("Ask a Question")
                            }
                        }
                        
                        NavigationLink {
                            EmptyView()
                        } label: {
                            HStack {
                                ZStack {
                                    Color.blue
                                        .cornerRadius(10)
                                        .frame(width: 30, height: 30)
                                    
                                    Image(systemName: "questionmark.circle.fill")
                                        .foregroundColor(.white)
                                }
                                
                                Text("Lovly kids FAQ")
                            }
                        }
                        
                        NavigationLink {
                            InfoByAppOffical()
                        } label: {
                            HStack {
                                ZStack {
                                    Color.red
                                        .cornerRadius(10)
                                        .frame(width: 30, height: 30)
                                    
                                    Image(systemName: "info")
                                        .foregroundColor(.white)
                                }
                                
                                Text("Info")
                            }
                        }
                    }
                    
                    Section {
                        Button("Log out") {
                            AuthService.shared.singOut()
                        }
                        .foregroundColor(.red)
                    }
                }
                .navigationTitle("Settings")
            }
        }
    }
}



