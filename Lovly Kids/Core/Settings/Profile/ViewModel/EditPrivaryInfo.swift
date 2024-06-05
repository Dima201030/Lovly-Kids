//
//  EditView.swift
//  Lovly Kids
//
//  Created by Дима Кожемякин on 05.03.2024.
//

import SwiftUI
import PhotosUI

struct EditPrivaryInfo: View {
    @StateObject private var profileViewModel = ProfileViewModel()
    @Environment (\.colorScheme) private var colorScheme
    @Environment(\.dismiss) private var dissmis
    
    @State private var fullname = ""
    @State private var age = ""
    @State private var selectColor = 1
    
    var user: User
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    PhotosPicker(selection: $profileViewModel.selectItme) {
                        if let profileImage = profileViewModel.profileImage {
                            ZStack {
                                Circle()
                                    .frame(width: 127, height: 127)
                                    .foregroundColor(profileViewModel.averageColor.map { Color($0) } ?? (colorScheme == .dark ? .gray : .black))
                                
                                profileImage
                                    .resizable()
                                    .cornerRadius(15)
                                    .scaledToFill()
                                    .clipShape(Circle())
                                    .frame(width: 120, height: 120)
                                    .shadow(color: profileViewModel.averageColor.map { Color($0) } ?? (colorScheme == .dark ? .white : .black), radius: 30) // Use average color in shadow
                                
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
                }
                
                Form {
                    
                    
                    Section {
                        TextField("Name", text: $fullname)
                            .font(.title2)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.center)
                        
                        TextField("Age", text: $age)
                        
                            .font(.subheadline)
                            .fontWeight(.light)
                            .multilineTextAlignment(.center)
                    }
                    
                    Section {
                        Picker(selection: $selectColor, label: Text("Color")) {
                            Text("Red").tag(1)
                            Text("Blue").tag(2)
                        }
                    }
                }
                Spacer()
                
            }
            .navigationTitle("EditProfile")
            .onAppear() {
                fullname = user.fullname
                age = String(user.age)
            }
            .navigationBarItems(leading: HStack {
                Button("Cancle") {
                    dissmis()
                }
                .fontWeight(.bold)
            }, trailing: HStack {
                Button("Done") {
                    let selectedColor = selectToColor(select: selectColor)
                    saveDataOfUser(fullname: fullname, age: age, email: user.email, profileColor: selectedColor)
                }
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
    
    private func saveDataOfUser(fullname: String, age: String, email: String, profileColor: String){
        Task {
            do {
                try await AuthService.shared.changeUserData(email: email, fullname: fullname, id: user.uid!, age: Int(age)!, profileColor: profileColor, profileImageUrl: user.profileImageUrl)
                try await UserService.shared.fetchCurrentUser() // Обновление данных текущего пользователя
            } catch {
                print("Failed to save user data with error: \(error.localizedDescription)")
            }
        }
        dissmis()
    }
    
    private func selectToColor(select: Int) -> String {
        switch select {
        case 1: "red"
        case 2: "blue"
        default: "gray"
        }
    }
}

#Preview {
    EditPrivaryInfo(user: User.MOCK_USER)
}
