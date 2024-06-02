//
//  LoginViewModel.swift
//  Manager
//
//  Created by Дима Кожемякин on 23.02.2024.
//

import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isProcessing = false
    
    func login() async throws {
        await MainActor.run {
            self.isProcessing = true
        }
        
        defer {
            Task { @MainActor in
                self.isProcessing = false
            }
        }
        
        try await AuthService.shared.login(withEmail: email, password: password)
    }
}
