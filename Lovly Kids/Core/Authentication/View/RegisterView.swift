//
//  RegistrationView.swift
//  ExamMessager
//
//  Created by Дима Кожемякин on 23.02.2024.
//

import SwiftUI

struct RegistrationView: View {
    
    @StateObject private var viewModel = RegistredViewModel()
    @Environment(\.dismiss) private var dissmis
    @Environment(\.colorScheme) private var colorScheme
    @State private var age = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [
                    Color("D3A58C").opacity(0.25),
                    Color(.systemBackground)],
                               startPoint: .top,
                               endPoint: .bottom
                )
                .ignoresSafeArea()
                
                VStack {
                    Spacer(minLength: 10)
                    
                    Image("LOVELYKIDS")
                        .resizable()
                        .cornerRadius(15)
                        .scaledToFit()
                        .shadow(color: Color("D3A58C"), radius: 30)
                        .frame(maxWidth: 300, maxHeight: 200)
                        .padding()
                    
                    Text("Sign up")
                        .font(.largeTitle.bold())
                        .padding(.bottom, 8)
                    
                    VStack(spacing: 14) {
                        BasicTextField(placeholder: "Email", text: $viewModel.email, keyboard: .emailAddress)
                        
                        BasicTextField(placeholder: "Password", text: $viewModel.password, isSecure: true)
                        
                        BasicTextField(placeholder: "FullName", text: $viewModel.fullName, isSecure: false)
                        
                        BasicTextField(placeholder: "Age", text: $age, isSecure: false)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 8)
                    
                    Button {
                        viewModel.age = Int(age) ?? 0
                        
                        Task {
                            try await viewModel.createUser()
                        }
                    } label: {
                        ZStack {
                            if viewModel.isAnimation {
                                ProgressView()
                            } else {
                                Text("Sign up")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(colorScheme == .dark ? .white : .black)
                            }
                        }
                        .frame(width: 330, height: 48)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                    }
                    .glassEffect(.regular.interactive())
                    .alert(viewModel.alertTitle, isPresented: $viewModel.showAlert) {
                        
                    } message: {
                        viewModel.alertMessage
                    }
                    .padding(.vertical)
                    
                    Spacer()
                    
                    Divider()
                    
                    Button {
                        dissmis()
                    } label: {
                        HStack(spacing: 3) {
                            Text("Already have an account ?")
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                            Text("Sign In")
                                .fontWeight(.semibold)
                                .foregroundColor(.blue)
                        }
                        .font(.footnote)
                    }
                    .padding(.vertical)
                    
                }
            }
        }
    }
}

#Preview {
    RegistrationView()
}
