//
//  NewMessangeViewModel.swift
//  Manager
//
//  Created by Дима Кожемякин on 27.02.2024.
//

import Foundation
import Firebase

@MainActor
class NewMessangeViewModel: ObservableObject {
    @Published var users = [User]()
    
    init() {
        Task { try await fotchUser() }
    }
    
    func fotchUser() async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let users = try await UserService.fetchAllUser()
        self.users = users.filter({ $0.id != currentUid})
    }
}
