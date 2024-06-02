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
            
            // Проверка и обновление сессии
            if let user = self.userSession {
                try await checkAndUpdateSession(for: user.uid)
            }
        } catch {
            print("DEBUG: Failed to login with error: \(error.localizedDescription)")
        }
    }

    @MainActor
    func createUser(withEmail email: String, password: String, fullname: String, age: Int, profileColor: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            try await self.uploadUserData(email: email, fullname: fullname, id: result.user.uid, age: age, profileColor: profileColor)
            loadCurrentUserData()
            
            // Создание новой сессии
            if let user = self.userSession {
                try await createNewSession(for: user.uid)
            }
            
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
            print("DEBUG: Failed to sign out with error: \(error.localizedDescription)")
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
            print("DEBUG: Failed to change user data with error: \(error.localizedDescription)")
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
    
    private func createNewSession(for userId: String) async throws {
        let sessionId = UUID().uuidString
        let sessionData: [String: Any] = [
            "date": Timestamp(date: Date()),
            "ip": getCurrentIPAddress(),
            "time": Timestamp(date: Date()),
            "blocked": true
        ]
        
        try await Firestore.firestore().collection("users").document(userId).collection("sessions").document(sessionId).setData(sessionData)
    }
    
    private func checkAndUpdateSession(for userId: String) async throws {
        let currentIP = getCurrentIPAddress()
        let sessionsRef = Firestore.firestore().collection("users").document(userId).collection("sessions")
        
        let querySnapshot = try await sessionsRef.whereField("ip", isEqualTo: currentIP).getDocuments()
        
        if let session = querySnapshot.documents.first {
            // Обновление существующей сессии
            let sessionId = session.documentID
            let sessionData: [String: Any] = [
                "date": Timestamp(date: Date()),
                "time": Timestamp(date: Date()),
                "blocked": false
            ]
            
            try await sessionsRef.document(sessionId).updateData(sessionData)
        } else {
            // Создание новой сессии
            try await createNewSession(for: userId)
        }
    }
    
    private func getCurrentIPAddress() -> String {
        // Здесь можно использовать подходящий метод для получения текущего IP-адреса
        // Пример: return "192.168.1.1"
        return "\(Int.random(in: 0...200))"
    }
}
