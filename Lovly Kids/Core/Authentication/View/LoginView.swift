//
//  LoginVIew.swift
//  ExamMessager
//
//  Created by Дима Кожемякин on 23.02.2024.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.colorScheme) var colorScheme
    //    @State private var yOffset: CGFloat = -100
    @StateObject var viewModel = LoginViewModel()
    //    @State private var animate = false
    //    @State private var isAnimation = false
    //    @State private var colors: [Color] = [Color("Pink"), Color("Pink-Red")]
    
    var body: some View {
        NavigationStack {
            VStack {
                
                //                    if isAnimation {
                //                        AnimatedRadialGradient(colors: [Color("Pink"), Color("Pink-Red")], startPoint: .bottom, endPoint: .center)
                //                            .edgesIgnoringSafeArea(.all)
                //                    } else {
                //                        RadialGradient(gradient: Gradient(colors: colors), center: .center, startRadius: 5, endRadius: 400)
                //                            .scaleEffect(2)
                //                            .offset(x: 0, y: yOffset)
                //                            .edgesIgnoringSafeArea(.all)
                //                    }
                
                VStack {
                    Spacer()
                    
                    // logo Image
                    Image("LOVELYKIDS")
                        .resizable()
                        .cornerRadius(15)
                        .scaledToFit()
                        .shadow(radius: 10)
                        .padding()
                    // You had an extra dot here. Removing it.
                    
                    Text("Lovely Kids")
                        .font(.custom("MonteCarlo-Regular", size: 36))
                        .foregroundColor(Color(red: 0.47, green: 0.35, blue: 0.30))
                        .frame(width: 160, height: 160)

                    Text("Регистрация")
                      .font(Font.custom("Montserrat-Regular", size: 20))
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
                    
                    // forgot password
                    Button(action: { /*isAnimation.toggle()*/} ) {
                        Text("Forgot your password")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .padding(.top)
                            .padding(.trailing, 20)
                            .foregroundColor(.black)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    
                    // login button
                    Button(action: {
                        //                            isAnimation.toggle() // Переключаем анимацию при нажатии на кнопку
                        Task {
                            try await viewModel.login()
                        }
                    }) {
                        Text("Login")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 360, height: 44)
                            .background(Color("EED8B7"))
                            .cornerRadius(10)
                    }
                    .padding(.vertical)
                    
                    // apple login
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
                    Button {
                        
                    } label: {
                        Text("Войдите через ")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                    }
                    .frame(width: 360, height: 44)                                .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("D3A58C"), lineWidth: 2)
                    )
                    .foregroundColor(Color.clear)
                    
                    Spacer()
                    
                    // sign up link
                    Divider()
                    NavigationLink {
                        RegistrationView()
                            .navigationBarBackButtonHidden()
                    } label: {
                        HStack (spacing: 3) {
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
