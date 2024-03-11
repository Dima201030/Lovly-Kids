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
        NavigationView {
            VStack {
                    List {
                        Section(header: Text("Profile")) {
                            NavigationLink(value: user) {
                                HStack {
                                    Image(systemName: "person.text.rectangle.fill")
                                    Text("Profile")
                                }
                            }
                            
                        }
                        Section {
                            ForEach(SettingsOptionsViewModel.allCases, id: \.self) { option in
                                NavigationLink(destination: option.destinationView) {
                                    HStack {
                                        Image(systemName: "\(option.icon)")
                                        Text(option.title)
                                            .font(.subheadline)
                                    }
                                }
                            }
                        }
                        Section(header: Text("Info")) {
                            HStack {
                                NavigationLink {
                                    InfoByAppOffical()
                                } label: {
                                    HStack {
                                        Image(systemName: "info")
                                        Text("Info")
                                    }
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
                    .navigationDestination(for: User.self, destination: { user in
                        ProfileView(user: user)
                    })
            }
        }
        
    }
}

#Preview {
    SettingsView()
        .environmentObject(AppData())
}
