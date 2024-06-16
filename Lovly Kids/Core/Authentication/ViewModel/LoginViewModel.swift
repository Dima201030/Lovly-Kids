//
//  LoginViewModel.swift
//  Manager
//
//  Created by Дима Кожемякин on 23.02.2024.
//

import SwiftUI

class LoginViewModel: ObservableObject {
    let generator = UINotificationFeedbackGenerator()
    @Published var email = ""
    @Published var password = ""
    @Published var isProcessing = false
    @Published var isActiveErrorAlert = false
    @Published var messageAlert = Text("")
    
    func login() async {
        await MainActor.run {
            self.isProcessing = true
        }
        
        defer {
            Task { @MainActor in
                self.isProcessing = false
            }
        }
        
        do {
            try await AuthService.shared.login(withEmail: email, password: password)
        } catch {
            await MainActor.run {
                self.error(errorString: error.localizedDescription)
                print(error.localizedDescription)
            }
        }
    }
    
    func error(errorString: String) {
        messageAlert = Text(NSLocalizedString(errorString, comment: ""))
        isActiveErrorAlert = true
    }
}
