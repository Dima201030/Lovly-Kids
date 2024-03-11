//
//  ProfileView.swift
//  Manager
//
//  Created by Дима Кожемякин on 23.02.2024.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewModel()
    @State private var fullname = ""
    @State private var age = ""
    @State private var showSheet = false
    @EnvironmentObject var appData: AppData
    let user: User
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.profileImage != nil {
                    Image(user.profileImageUrl ?? "")
                        .resizable()
                        .frame(width: 120, height: 120)
                        .foregroundColor(Color(.systemGray4))
                        .scaledToFill()
                        .clipShape(Circle())
                } else {
                    CircularProfileImageView(user: user, size: .max)
                }
                List {
                    Section {
                        Button {
                            showSheet.toggle()
                        } label: {
                            Text("Edit Bio")
                        }
                    }
                    Section {
                        ForEach(SettingsProfileEnum.allCases){ options in
                            NavigationLink {
                                PrivacyView()
                            } label: {
                                HStack {
                                    Image(systemName: "\(options.imageUrl)")
                                    Text("\(options.title)")
                                }
                            }
                        }

                    }
                    Section {
                        Button(action: {AuthService.shared.deleteUser()}) {
                            Text("Delete account")
                                .foregroundColor(.red)
                        }
                    }
                }
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Profile")
            .sheet(isPresented: $showSheet, content: {
                EditPrivaryInfo(user: user)
                    .environmentObject(AppData())
            })
        }
    }
    
}

#Preview {
    ProfileView(user: User.MOCK_USER)
        .environmentObject(AppData())

}
