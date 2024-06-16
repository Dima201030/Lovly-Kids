//
//  MainView.swift
//  Lovly Kids
//
//  Created by Дима Кожемякин on 10.05.2024.
//

import SwiftUI
import Firebase

struct Verefi: View {
    @State private var email = ""
    @State private var message = ""
    @State private var isVerified = false
    @State private var showingVerificationScreen = false

    var body: some View {
        if isVerified {
            VStack {
                Text("Email successfully verified!")
                    .font(.largeTitle)
                    .padding()
                VStack {
                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    Button(action: sendVerificationCode) {
                        Text("Send Verification Code")
                    }
                    .padding()
                    Text(message)
                        .padding()
                    Button(action: checkVerificationStatus) {
                        Text("Check Verification Status")
                    }
                    .padding()
                }
                .padding()
            }
            
            
        } else {
            VStack {
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                Button(action: sendVerificationCode) {
                    Text("Send Verification Code")
                }
                .padding()
                Text(message)
                    .padding()
                Button(action: checkVerificationStatus) {
                    Text("Check Verification Status")
                }
                .padding()
            }
            .padding()
            .onAppear {
                checkVerificationStatus()
            }
        }
    }

    func sendVerificationCode() {
        Auth.auth().currentUser?.sendEmailVerification(completion: { error in
            if let error = error {
                message = "Error: \(error.localizedDescription)"
            } else {
                message = "Verification email sent."
                showingVerificationScreen = true
            }
        })
    }

    func checkVerificationStatus() {
        Auth.auth().currentUser?.reload(completion: { error in
            if let user = Auth.auth().currentUser {
                if user.isEmailVerified {
                    isVerified = true
                } else {

                }
            }
        })
    }
}


struct MainView: View {
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
            ZStack {
                if colorScheme == .dark {
                    Color.black
                } else {
                    Color("F9F6F1")
                        .ignoresSafeArea(edges: .bottom)
                }
                
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack {
                        Storis()
                            .cornerRadius(35)
                            .frame(width: UIScreen.main.bounds.width, height: 200)
                            .offset(y: colorScheme == .dark ? CGFloat(0) : -38)
                        
                        if colorScheme == .dark {
                            Image("mama-pervoe-slovo-in")
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width - 16, height: 200)
//                                .offset(y: -5)
                        } else {
                            Image("emotional-baggage")
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width - 16, height: 350)
//                                .offset(y: 0)
                        }
                        
                        OftenOrder()
                            .cornerRadius(35)
                            .frame(width: UIScreen.main.bounds.width - 16, height: 300)
                        
                        Achievements()
                            .cornerRadius(35)
                            .frame(width: UIScreen.main.bounds.width - 16, height: 300)
                            .padding()
                    }
                }
            }
            .refreshable {
                do {

                }
            }
            .navigationBarTitleDisplayMode(.inline)
        
    }
}

#Preview {
    MainView()
        .colorScheme(.light)
}
