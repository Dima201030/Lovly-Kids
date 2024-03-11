//
//  EditView.swift
//  Lovly Kids
//
//  Created by Дима Кожемякин on 05.03.2024.
//

import SwiftUI
import PhotosUI

struct EditPrivaryInfo: View {
    @StateObject var viewModel = ProfileViewModel()
    @State private var fullname = ""
    @State private var age = ""
    @Environment(\.dismiss) var dissmis
    let user: User
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    PhotosPicker(selection: $viewModel.selectItme) {
                        if let profileImage = viewModel.profileImage {
                            profileImage
                                .resizable()
                                .frame(width: 120, height: 120)
                                .foregroundColor(Color(.systemGray4))
                                .scaledToFill()
                                .clipShape(Circle())
                        } else {
                            CircularProfileImageView(user: user, size: .max)
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
                    
                    
                }
                Spacer()
                
            }
            .navigationTitle("EditProfile")
            .onAppear() {
                fullname = user.fullname
                age = String(user.age)
            }
            .navigationBarItems(leading: HStack {
                Button {
                    dissmis()
                } label: {
                    Text("Cancle")
                        .fontWeight(.bold)
                }
            }, trailing: HStack {
                Button {
                    saveDataOfUser(fullname: fullname, age: "12", email: "\(user.email)")
                } label: {
                    Text("Done")
                }
                
            })
        }
        
    }
    
    
    private func saveDataOfUser(fullname: String, age: String, email: String){
        Task {
            try await AuthService.shared.changeUserData(email: email, fullname: fullname, id: user.uid!, age: Int(age)!)
        }
        dissmis()
    }
    
}

#Preview {
    EditPrivaryInfo(user: User.MOCK_USER)
}
