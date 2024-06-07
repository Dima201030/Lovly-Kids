//
//  UserService.swift
//  Manager
//
//  Created by Дима Кожемякин on 26.02.2024.
//

import Firebase
import FirebaseFirestoreSwift

class UserService {
    @Published var currentUser: User?
    
    static let shared = UserService()
    
    @MainActor
    func fetchCurrentUser() async throws {
        do {
            guard let uid = Auth.auth().currentUser?.uid else { return }
            let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
            let user = try snapshot.data(as: User.self)
            self.currentUser = user
            print("userUID: \(uid), data: \(snapshot), user: \(user)")
        } catch {
            print("DEBUG: Failed to create user with error: \(error.localizedDescription)")
        }
    }
    
    static func fetchUserAllPartners(for userId: String) async throws -> [User] {
        Task {
            try await AuthService.shared.createNewPartner(for: userId, currentUserID: "S55Rysh3kBdcmn3KIvpMEFzveXf1")
        }
        let snapshot = try await Firestore.firestore().collection("users").document(userId).collection("partners").getDocuments()
        print("DEBUG: \(snapshot)")
        return snapshot.documents.compactMap {
            try? $0.data(as: User.self)
        }
    }
    
    static func fetchUser(withUid uid: String, completion: @escaping(User) -> Void) {
        FirestoreConstants.UserCollection.document(uid).getDocument { snapshot, _ in
            guard let user = try? snapshot?.data(as: User.self) else { return }
            completion(user)
        }
    }
}
