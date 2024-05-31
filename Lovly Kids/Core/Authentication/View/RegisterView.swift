//
//  RegistrationView.swift
//  ExamMessager
//
//  Created by Дима Кожемякин on 23.02.2024.
//

import SwiftUI

struct RegistrationView: View {
    @StateObject var viewModel = RegistredViewModel()
    @Environment(\.dismiss) var dissmis
    @State private var age = ""
    var body: some View {
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
            
            Text("Регистрация")
              .font(Font.custom("Montserrat-Regular", size: 20))
              .foregroundColor(.black)
            
            VStack {
                TextField("Enter your email", text: $viewModel.email)
                    .font(.subheadline)
                    .padding(12)
                    .background(Color("EED8B7"))
                    .cornerRadius(10)
                    .padding(.horizontal, 24)
                    .keyboardType(.emailAddress)
                
                SecureField("Enter your password", text: $viewModel.password)
                    .font(.subheadline)
                    .padding(12)
                    .background(Color("EED8B7"))
                    .cornerRadius(10)
                    .padding(.horizontal, 24)
                    .keyboardType(.default)
                
                TextField("Enter your Fullname", text: $viewModel.fullName)
                    .font(.subheadline)
                    .padding(12)
                    .background(Color("EED8B7"))
                    .cornerRadius(10)
                    .padding(.horizontal, 24)
                    .keyboardType(.default)
                
                TextField("Enter your age", text: $age)
                    .font(.subheadline)
                    .padding(12)
                    .background(Color("EED8B7"))
                    .cornerRadius(10)
                    .padding(.horizontal, 24)
                    .keyboardType(.numberPad)
            }
            
            
            Button(action: {
                
                viewModel.age = Int(age) ?? 0
                
                Task { try await viewModel.createUser() }
            } ) {
                Text("Sign In")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(width: 360, height: 44)
                    .background(Color("EED8B7"))
                    .cornerRadius(10)
                
            }
            .alert(isPresented: $viewModel.showAlert, content: {
                Alert(title: Text(viewModel.alertTitle), message: Text(viewModel.alertMessage))
            })
            .padding(.vertical)
            
            Spacer()
            
            Divider()
            
            Button {
                dissmis()
            } label: {
                HStack (spacing: 3) {
                    Text("Already have an account ?")
                    
                    Text("Sign In")
                        .fontWeight(.semibold)
                }
                .font(.footnote)
            }
            .padding(.vertical)
        }
    }
    
}

#Preview {
    RegistrationView()
}
