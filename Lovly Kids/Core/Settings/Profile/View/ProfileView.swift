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
                                .shadow(color: profileViewModel.averageColor.map { Color($0) } ?? (colorScheme == .dark ? Color.white : Color.black), radius: 30) // Use average color in shadow
                            
                        }
                    } else {
                        Circle()
                            .frame(width: 120, height: 120)
                            .foregroundColor(profileViewModel.averageColor.map { Color($0) } ?? (colorScheme == .dark ? Color.white : Color.black))
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
                }
                .offset(y: 25)
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
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


//struct ProfileView: View {
//    @StateObject var profileViewModel = ProfileViewModel()
//    @Environment (\.colorScheme) var colorScheme
//    @State private var fullname = ""
//    @State private var age = ""
//    @State private var showSheet = false
//    @EnvironmentObject var appData: AppData
//    let user: User
//    var body: some View {
//        NavigationView {
//            VStack {
//                ZStack {
//                    Circle()
//                        .frame(width: 127, height: 127)
//                        .foregroundColor(profileViewModel.averageColor.map { Color($0) } ?? (colorScheme == .dark ? Color.white : Color.black))
//
//                    PhotosPicker(selection: $profileViewModel.selectItme) {
//                        if let profileImage = profileViewModel.profileImage {
//                            profileImage
//                                .resizable()
//                                .cornerRadius(15)
//                                .scaledToFill()
//                                .clipShape(Circle())
//                                .frame(width: 120, height: 120)
//                                .shadow(color: profileViewModel.averageColor.map { Color($0) } ?? (colorScheme == .dark ? Color.white : Color.black), radius: 30) // Use average color in shadow
//
//                        } else {
//                            Image("person.circle")
//                                .resizable()
//                                .cornerRadius(15)
//                                .scaledToFill()
//                                .clipShape(Circle())
//                                .frame(width: 120, height: 120)
//                                .shadow(color: profileViewModel.averageColor.map { Color($0) } ?? (colorScheme == .dark ? Color.white : Color.black), radius: 30) // Use average color in shadow
//
//                        }
//                    }
//                }
//                List {
//                    Section {
//                        Button {
//                            showSheet.toggle()
//                        } label: {
//                            Text("Edit Bio")
//                        }
//                    }
//                    Section {
//                        ForEach(SettingsProfileEnum.allCases){ options in
//                            NavigationLink {
//                                PrivacyView()
//                            } label: {
//                                HStack {
//                                    Image(systemName: "\(options.imageUrl)")
//                                    Text("\(options.title)")
//                                }
//                            }
//                        }
//
//                    }
//                    Section {
//                        Button(action: {AuthService.shared.deleteUser()}) {
//                            Text("Delete account")
//                                .foregroundColor(.red)
//                        }
//                    }
//                }
//
//            }
//            .navigationBarTitleDisplayMode(.inline)
//            .navigationTitle("Profile")
//            .sheet(isPresented: $showSheet, content: {
//                EditPrivaryInfo(user: user)
//                    .environmentObject(AppData())
//            })
//        }
//    }
//
//}

#Preview {
    ProfileView(user: User.MOCK_USER)
        .environmentObject(AppData())
    
}
