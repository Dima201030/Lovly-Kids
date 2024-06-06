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
                        .frame(maxWidth: 200, maxHeight: 200)
                    
                    Text("Lovely Kids")
                        .font(.custom("MonteCarlo-Regular", size: 36))
                        .foregroundColor(Color(red: 0.47, green: 0.35, blue: 0.30))
                    
                    
                    Text("Log in")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    VStack {
                        
                        TextField("", text: $viewModel.email, prompt: Text("Email").font(.subheadline).fontWeight(.regular).foregroundColor(/*colorScheme == .dark ? Color(.black) :*/ Color(red: 0.724, green: 0.665, blue: 0.583))
                        )
                        .padding(12)
                        .background(Color("EED8B7"))
                        .cornerRadius(10)
                        .padding(.horizontal, 24)
                        .keyboardType(.emailAddress)
                        .foregroundColor(.black)
                        
                        SecureField("", text: $viewModel.password, prompt: Text("Password").font(.subheadline).fontWeight(.regular).foregroundColor(/*colorScheme == .dark ? Color(.black) :*/ Color(red: 0.724, green: 0.665, blue: 0.583))
                        )
                        .font(.subheadline)
                        .padding(12)
                        .background(Color("EED8B7"))
                        .cornerRadius(10)
                        .padding(.horizontal, 24)
                        .keyboardType(.default)
                        .foregroundColor(.black)
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
                                .foregroundColor(.black)
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
                            .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                        Text("OR")
                            .font(.footnote)
                            .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                            .fontWeight(.semibold)
                        Rectangle()
                            .frame(width: (UIScreen.main.bounds.width / 2) - 40, height: 0.5)
                            .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                    }
                    .foregroundColor(.gray)
                    
                    Spacer()
                    
                    NavigationLink {
                        LoginWithPhone()
                    } label: {
                        Text("Log in with phone")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
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
                                .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                            
                            Text("Sign Up")
                                .fontWeight(.semibold)
                                .foregroundColor(Color.blue)
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
