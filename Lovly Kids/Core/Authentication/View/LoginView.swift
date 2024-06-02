//
//  LoginVIew.swift
//  ExamMessager
//
//  Created by Дима Кожемякин on 23.02.2024.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    Spacer()
                    Image("LOVELYKIDS")
                        .resizable()
                        .cornerRadius(15)
                        .scaledToFit()
                        .shadow(radius: 10)
                        .padding()
                    
                    Text("Lovely Kids")
                        .font(.custom("MonteCarlo-Regular", size: 36))
                        .foregroundColor(Color(red: 0.47, green: 0.35, blue: 0.30))
                        .frame(width: 160, height: 160)
                    
                    Text("Вход")
                        .font(.custom("Montserrat-Regular", size: 20))
                        .foregroundColor(.black)
                    
                    VStack {
                        TextField(NSLocalizedString("Email", comment: ""), text: $viewModel.email)
                            .font(.subheadline)
                            .padding(12)
                            .background(Color("EED8B7"))
                            .cornerRadius(10)
                            .padding(.horizontal, 24)
                            .keyboardType(.emailAddress)
                        
                        SecureField("Password", text: $viewModel.password)
                            .font(.subheadline)
                            .padding(12)
                            .background(Color("EED8B7"))
                            .cornerRadius(10)
                            .padding(.horizontal, 24)
                            .keyboardType(.default)
                    }
                    
                    Button(action: { /*isAnimation.toggle()*/} ) {
                        Text("Forgot your password")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .padding(.top)
                            .padding(.trailing, 20)
                            .foregroundColor(.black)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    
                    Button(action: {
                        Task {
                            try await viewModel.login()
                        }
                    }) {
                        if !viewModel.isProcessing {
                            Text("Login")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(width: 360, height: 44)
                                .background(Color("EED8B7"))
                                .cornerRadius(10)
                        } else {
                            ProgressView()
                                .frame(width: 360, height: 44)
                        }
                    }
                    .padding(.vertical)
                    
                    HStack {
                        Rectangle()
                            .frame(width: (UIScreen.main.bounds.width / 2) - 40, height: 0.5)
                            .foregroundColor(.black)
                        Text("OR")
                            .font(.footnote)
                            .foregroundColor(.black)
                            .fontWeight(.semibold)
                        Rectangle()
                            .frame(width: (UIScreen.main.bounds.width / 2) - 40, height: 0.5)
                            .foregroundColor(.black)
                    }
                    .foregroundColor(.gray)
                    
                    Spacer()
                    
                    NavigationLink {
                        LoginWithPhone()
                    } label: {
                        Text("Log in with phone")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                    }
                    .frame(width: 360, height: 44)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("D3A58C"), lineWidth: 2)
                    )
                    .foregroundColor(.clear)
                    
                    Spacer()
                    
                    Divider()
                    
                    NavigationLink {
                        RegistrationView()
                            .navigationBarBackButtonHidden()
                    } label: {
                        HStack(spacing: 3) {
                            Text("Don't have an account ?")
                                .foregroundColor(.black)
                            
                            Text("Sign Up")
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                        }
                        .font(.footnote)
                    }
                }
                .padding(.vertical)
            }
        }
    }
}

#Preview {
    LoginView()
}
