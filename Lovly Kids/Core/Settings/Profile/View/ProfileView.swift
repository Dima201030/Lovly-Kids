//
//  ProfileView.swift
//  Manager
//
//  Created by Дима Кожемякин on 23.02.2024.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    let user: User
    @StateObject var profileViewModel = ProfileViewModel()
    @Environment(\.colorScheme) var colorScheme
    @State private var showSheet = false
    var body: some View {
        NavigationStack {
            VStack {
                PhotosPicker(selection: $profileViewModel.selectItme) {
                    if let profileImage = profileViewModel.profileImage {
                        ZStack {
                            Circle()
                                .frame(width: 127, height: 127)
                                .foregroundColor(profileViewModel.averageColor.map { Color($0) } ?? (colorScheme == .dark ? Color.gray : Color.black))
                            
                            profileImage
                                .resizable()
                                .cornerRadius(15)
                                .scaledToFill()
                                .clipShape(Circle())
                                .frame(width: 120, height: 120)
                                .shadow(color: colorScheme == .dark ? (profileViewModel.averageColor.map { Color($0) } ?? (colorScheme == .dark ? Color.white : Color.black)) : Color.white, radius: 30) // Use average color in shadow
                            
                        }
                    } else {
                        Circle()
                            .frame(width: 120, height: 120)
                            .foregroundColor(profileViewModel.averageColor.map { Color($0) } ?? (user.profileColor))
                            .overlay(
                                // Добавляем случайную букву "P" внутри круга
                                Text("\(firstWordOfName())")
                                    .font(.system(size: 50, weight: .bold, design: .default))
                                    .foregroundColor(.white)
                            )
                    }
                }
                List {
                    Section {
                        Button {
                            showSheet.toggle()
                        } label: {
                            HStack {
                                Image(systemName: "person.text.rectangle")
                                Text("Edit main data")
                            }
                            .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                        }
                        
                    }
                    Section {
                        Button(action: {AuthService.shared.singOut()}) {
                            Text("Log out")
                                .foregroundColor(.red)
                        }
                    }
                }
                .offset(y: 25)
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showSheet, content: {
                EditPrivaryInfo(user: user)
                    .environmentObject(AppData())
            })
        }
    }
    private func firstWordOfName() -> String {
        var words: [Character] = []
        
        for i in user.fullname {
            words.append(i)
        }
        return "\(words[0])"
    }
}

#Preview {
    ProfileView(user: User.MOCK_USER)
        .environmentObject(AppData())
    
}
