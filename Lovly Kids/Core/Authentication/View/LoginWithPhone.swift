//
//  LoginWithPhone.swift
//  Lovly Kids
//
//  Created by Дима Кожемякин on 17.05.2024.
//

import SwiftUI
import FirebaseAuth
import Firebase

struct LoginWithPhone: View {
    //    @StateObject private var viewModel = LoginWithPhoneViewModel()
    var body: some View {
        //        FirstPage()
        VStack {
            
        }
    }
}

//struct FirstPage: View {
//    @State private var show = false
//    @State private var msg = ""
//    @State private var alert = false
//    @State private var ID = ""
//    @StateObject private var viewModel = LoginWithPhoneViewModel()
//
//    var body: some View {
//        NavigationStack {
//            VStack(spacing: 20) {
//                Text("Verefi Your Number")
//                    .font(.largeTitle)
//                    .fontWeight(.heavy)
//                Text("Please Enter Your Number To Verefy Your Account")
//                    .font(.body)
//                    .foregroundColor(.gray)
//                HStack {
//                    TextField("1", text: $viewModel.countryNumber)
//                        .frame(width: 45)
//                        .padding()
//                        .background(Color("EED8B7"))
//                        .clipShape(RoundedRectangle(cornerRadius: 10))
//                        .keyboardType(.phonePad)
//                    TextField("number", text: $viewModel.phone)
//                        .padding()
//                        .background(Color("EED8B7"))
//                        .clipShape(RoundedRectangle(cornerRadius: 10))
//                        .keyboardType(.phonePad)
//                } .padding(.top, 15)
//                NavigationLink(destination: SecondPage(ID: $ID), isActive: $show){
//                    Button {
//                        PhoneAuthProvider.provider().verifyPhoneNumber("+"+viewModel.countryNumber+viewModel.phone, uiDelegate: nil) { (ID, err) in
//
//                            if err != nil {
//                                msg = (err?.localizedDescription)!
//                                alert.toggle()
//                                return
//                            }
//                            self.ID = ID!
//                            show.toggle()
//                        }
//                    } label: {
//                        Text("Done")
//                            .frame(width: UIScreen.main.bounds.width - 30, height: 50)
//
//                    }
//                }
//                .foregroundColor(.white)
//                .background(.orange)
//                .cornerRadius(10)
//            }
//            .padding()
//        }
//    }
//}
//
//struct SecondPage: View {
//    @Published var userSession: FirebaseAuth.User?
//    @State private var msg = ""
//    @State private var alert = false
//    @Binding var ID: String
//    @StateObject private var viewModel = LoginWithPhoneViewModel()
//
//    var body: some View {
//        NavigationStack {
//            VStack(spacing: 20) {
//                Text("Verefi Code")
//                    .font(.largeTitle)
//                    .fontWeight(.heavy)
//                Text("Please Enter verefy Code")
//                    .font(.body)
//                    .foregroundColor(.gray)
//
//                TextField("Code", text: $viewModel.code)
//                    .padding()
//                    .background(Color("EED8B7"))
//                    .clipShape(RoundedRectangle(cornerRadius: 10))
//                    .keyboardType(.phonePad)
//                    .padding(.top, 15)
//
//                Button {
//                    let credential = PhoneAuthProvider.provider().credential(withVerificationID: ID, verificationCode: viewModel.code)
//                    let result = Auth.auth().signIn(with: credential) { (res, err) in
//                        if err != nil {
//                            msg = (err?.localizedDescription)!
//                            alert.toggle()
//                            return
//                        }
//
//                    }
//                    self.userSession = result.user
//                } label: {
//                    Text("Done")
//                        .frame(width: UIScreen.main.bounds.width - 30, height: 50)
//                }
//                .foregroundColor(.white)
//                .background(.orange)
//                .cornerRadius(10)
//            }
//            .navigationBarHidden(true)
//            .navigationTitle("")
//            .navigationBarBackButtonHidden(true)
//            .padding()
//        }
//    }
//}
//
//#Preview {
//    LoginWithPhone()
//}
