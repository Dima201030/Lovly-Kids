//
//  SettingsView.swift
//  Lovly Kids
//
//  Created by Дима Кожемякин on 29.02.2024.
//

import SwiftUI
import TipKit


struct SettingsView: View {
    private let hintTipProfile = HintTipSettigns(titleWeite: "Look at that!", messageWrite: "See what your profile looks like and how others see it", imageString: "person.crop.rectangle")
    private let hintTipLanguage = HintTipSettigns(titleWeite: "And here...", messageWrite: "And here you can change the language", imageString: "globe")
    private let hintTipProfileDevice = HintTipSettigns(titleWeite: "Look at that!", messageWrite: "See what your profile looks like and how others see it", imageString: "person.crop.rectangle")
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
                            .conditionalPopoverTip(hintTipProfile, isTipVisible: $isTipVisible)  // Используем кастомный модификатор
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
                            .conditionalPopoverTip(option.tip, isTipVisible: $isTipVisible)  // Используем кастомный модификатор
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

#Preview {
    SettingsView()
        .environmentObject(AppData())
}

struct HintTipSettigns: Tip {
    let titleWeite: String
    let messageWrite: String
    let imageString: String
    var title: Text {
        Text("\(titleWeite)")
    }
    
    var message: Text? {
        Text("\(messageWrite)")
    }
    
    var image: Image? {
        Image(systemName: "\(imageString)")
    }
}


