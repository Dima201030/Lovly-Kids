//
//  SettingsView.swift
//  Lovly Kids
//
//  Created by Дима Кожемякин on 29.02.2024.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var viewModel = InboxViewModel()
    @EnvironmentObject var appData: AppData
    private var user: User? {
        return viewModel.currentUser
    }
    var body: some View {
        NavigationStack {
            ZStack {
                Color("F9F6F1")
                List {
                    
                    if let user = user {
                        Section {
                            
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
                                        Image(systemName: "\(option.icon)")
                                            .foregroundColor(.white)
                                    }
                                    Text(option.title)
                                        .font(.subheadline)
                                }
                            }
                        }
                    }
                    
                    Section{
                        NavigationLink {
                            EmptyView()
                        } label: {
                            HStack{
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
                    Section{
                        NavigationLink {
                            EmptyView()
                        } label: {
                            HStack{
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
                            HStack{
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
                        Button(action: {AuthService.shared.singOut()}) {
                            Text("Log out")
                                .foregroundColor(.red)
                        }
                    }
                }
                .navigationTitle("Settings")
            }
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(AppData())
}
