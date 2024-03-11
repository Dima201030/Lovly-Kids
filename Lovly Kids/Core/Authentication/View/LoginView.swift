//
//  LoginVIew.swift
//  ExamMessager
//
//  Created by Дима Кожемякин on 23.02.2024.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                // logo Image
                Image("LOVELYKIDS")
                    .resizable()
                    .cornerRadius(15)
                    .scaledToFit()
                    .shadow(radius: 10)
                    .frame(width: 150, height: 150)
                    .padding()
                    
                // text fields
                VStack {
                    TextField("Enter your email", text: $viewModel.email)
                        .font(.subheadline)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal, 24)
                    
                    SecureField("Enter your password", text: $viewModel.password)
                        .font(.subheadline)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal, 24)
                }
                
                // forgot password
                
                Button(action: {} ) {
                    Text("Forgot your password")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .padding(.top)
                        .padding(.trailing, 20)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                
                // login button
                Button(action: { Task { try await viewModel.login() }} ) {
                    Text("Login")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 360, height: 44)
                        .background(Color(.systemBlue))
                        .cornerRadius(10)
                    
                }
                .padding(.vertical)
                // apple login
                HStack {
                    Rectangle()
                        .frame(width: (UIScreen.main.bounds.width / 2) - 40, height: 0.5)
                    Text("OR")
                        .font(.footnote)
                        .fontWeight(.semibold)
                    Rectangle()
                        .frame(width: (UIScreen.main.bounds.width / 2) - 40, height: 0.5)
                }
                .foregroundColor(.gray)
                HStack {
                    Image("Gogole")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .clipShape(Circle())
                    
                    Text("Countinue with Facebook")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundColor(Color(.systemBlue))
                        
                }
                .padding(.top, 8)
                Spacer()
                // sign up link
                
                Divider()
                NavigationLink {
                    RegistrationView()
                        .navigationBarBackButtonHidden()
                } label: {
                    HStack (spacing: 3) {
                        Text("Don't have an account ?")
                        
                        Text("Sign Up")
                            .fontWeight(.semibold)
                    }
                    .font(.footnote)
                }
                .padding(.vertical)
            }
        }
    }
}

#Preview {
    LoginView()
}
