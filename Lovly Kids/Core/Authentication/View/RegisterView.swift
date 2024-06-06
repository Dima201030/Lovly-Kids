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
            
            Text("Sig in")
                .font(.title)
                .fontWeight(.bold)
            VStack {
                TextField("", text: $viewModel.email, prompt: Text("Email")
                    .font(.subheadline)
                    .fontWeight(.regular)
                    .foregroundColor(/*colorScheme == .dark ? Color(.black) :*/ Color(red: 0.724, green: 0.665, blue: 0.583)
                                    ))
                    .font(.subheadline)
                    .padding(12)
                    .background(Color("EED8B7"))
                    .cornerRadius(10)
                    .padding(.horizontal, 24)
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                    .textInputAutocapitalization(.never)
                
                SecureField("", text: $viewModel.password, prompt: Text("Password")
                    .font(.subheadline)
                    .fontWeight(.regular)
                    .foregroundColor(/*colorScheme == .dark ? Color(.black) :*/ Color(red: 0.724, green: 0.665, blue: 0.583)
                                    ))
                    .font(.subheadline)
                    .padding(12)
                    .background(Color("EED8B7"))
                    .cornerRadius(10)
                    .padding(.horizontal, 24)
                    .keyboardType(.default)
                    .textContentType(.newPassword)
                
                TextField("", text: $viewModel.fullName, prompt: Text("Your name")
                    .font(.subheadline)
                    .fontWeight(.regular)
                    .foregroundColor(/*colorScheme == .dark ? Color(.black) :*/ Color(red: 0.724, green: 0.665, blue: 0.583)
                                    ))
                    .font(.subheadline)
                    .padding(12)
                    .background(Color("EED8B7"))
                    .cornerRadius(10)
                    .padding(.horizontal, 24)
                    .keyboardType(.default)
                    .textContentType(.name)
                
                TextField("", text: $age, prompt: Text("Age")
                    .font(.subheadline)
                    .fontWeight(.regular)
                    .foregroundColor(/*colorScheme == .dark ? Color(.black) :*/ Color(red: 0.724, green: 0.665, blue: 0.583)
                                    ))
                    .font(.subheadline)
                    .padding(12)
                    .background(Color("EED8B7"))
                    .cornerRadius(10)
                    .padding(.horizontal, 24)
                    .keyboardType(.numberPad)
            }
            
            Button {
                viewModel.age = Int(age) ?? 0
                
                Task {
                    try await viewModel.createUser()
                }
            } label: {
                Text("Sign Up")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(colorScheme == .dark ? Color.black : Color.white)
                    .frame(width: 360, height: 44)
                    .background(Color("EED8B7"))
                    .cornerRadius(10)
            }
            .alert(viewModel.alertTitle, isPresented: $viewModel.showAlert) {
                
            } message: {
                Text(viewModel.alertMessage)
            }
            .padding(.vertical)
            
            Spacer()
            
            Divider()
            
            Button {
                dissmis()
            } label: {
                HStack(spacing: 3) {
                    Text("Already have an account ?")
                        .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
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

#Preview {
    RegistrationView()
}
