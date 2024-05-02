//
//  RegistredViewModel.swift
//  Manager
//
//  Created by Дима Кожемякин on 23.02.2024.
//

import SwiftUI

class RegistredViewModel: ObservableObject {
    @Published var isAnimation = false
    @Published var email = ""
    @Published var password = ""
    @Published var fullName = ""
    @Published var age = 0
    
    @Published var showAlert = false
    @Published var alertTitle = "Error"
    @Published var alertMessage = "Error text"
    
    
    func createUser() async throws {
        isAnimation.toggle()
        
        if age <= 14 {
            alertTitle = "Error"
            alertMessage = "You're too small for this app."
            showAlert.toggle()
            isAnimation.toggle()
            return
        }
        guard email != "", password != "", fullName != "" else {
            alertTitle = "Error"
            alertMessage = "Not all fields are filled in"
            showAlert.toggle()
            isAnimation.toggle()
            return
        }
        
        try await AuthService.shared.createUser(withEmail: email, password: password, fullname: fullName, age: age)
        isAnimation.toggle()
    }
}
