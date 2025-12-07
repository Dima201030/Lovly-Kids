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
//        let defaultUser = User(uid: "WOkWTseGz1RlrM6Tcd1gDfNRrp13", fullname: "dmdmmdmd", email: "dmdmmdmddmdmmdmd@gmail.com", age: 72, profileImageUrl: "https://firebasestorage.googleapis.com:443/v0/b/messanger-8c488.appspot.com/o/images%2F0990F31F-AE73-4775-A90A-9ACF46675E20.jpg?alt=media&token=4aba4f21-9d34-429f-aa97-0d71d8592374", profileColorString: "blue")
//        self.users = [defaultUser]

        Task {
            try await fotchUser()
        }
    }
    
    func fotchUser() async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        let fetchedUsers = try await UserService.fetchUserAllPartners(for: currentUid)
        
        self.users += fetchedUsers.filter { $0.id != currentUid }
    }
}
