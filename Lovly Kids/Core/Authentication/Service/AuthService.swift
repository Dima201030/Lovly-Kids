//
//  AuthService.swift
//  Manager
//
//  Created by Дима Кожемякин on 23.02.2024.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class AuthService {
    
    @Published var userSession: FirebaseAuth.User?
    
    static let shared = AuthService()
    
    init() {
        self.userSession = Auth.auth().currentUser
        loadCurrentUserData()
    }
    
    @MainActor
    func login(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            loadCurrentUserData()
        } catch {
        }
    }
    
    @MainActor
    func createUser(withEmail email: String, password: String, fullname: String, age: Int, profileColor: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            try await self.uploadUserData(email: email, fullname: fullname, id: result.user.uid, age: age, profileColor: profileColor)
            loadCurrentUserData()
            
            
        } catch {
            print("DEBUG: Failed to create user with error: \(error.localizedDescription)")
        }
    }
    func singOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            UserService.shared.currentUser = nil
        } catch {
            
        }
    }
    
    private func uploadUserData(email: String, fullname: String, id: String, age: Int, profileColor: String) async throws {
        let user = User(fullname: fullname, email: email, age: age, profileImageUrl: "", profileColorString: profileColor)
        guard let encodedUser = try? Firestore.Encoder().encode(user) else { return }
        try await Firestore.firestore().collection("users").document(id).setData(encodedUser)
    }
    
    func changeUserData(email: String, fullname: String, id: String, age: Int, profileColor: String, profileImageUrl: String) async throws {
        do {
            let user = User(fullname: fullname, email: email, age: age, profileImageUrl: profileImageUrl, profileColorString: profileColor)
            guard let encodedUser = try? Firestore.Encoder().encode(user) else { return }
            try await Firestore.firestore().collection("users").document(id).setData(encodedUser)
        } catch {
            
        }
    }
    
    private func loadCurrentUserData() {
        Task { try await UserService.shared.fetchCurrentUser() }
    }
    
    func deleteUser() {
        let user = Auth.auth().currentUser

        user?.delete { error in
          if let error = error {
              self.singOut()
          } else {              
              self.singOut()
          }
        }
    }
    
}
