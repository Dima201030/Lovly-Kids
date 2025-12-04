//
//  AuthService.swift
//  Manager
//
//  Created by Дима Кожемякин on 23.02.2024.
//

import SwiftUI
import Firebase
import TipKit
import FirebaseFirestore

class AuthService {
    static let shared = AuthService()
    
    @Published var userSession: FirebaseAuth.User?
    
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
            
            if let user = self.userSession {
                try await checkAndUpdateSession(for: user.uid)
            }
        } catch {
            throw error
        }
    }
    
    @MainActor
    func createUser(withEmail email: String, password: String, fullname: String, age: Int, profileColor: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            try await self.uploadUserData(email: email, fullname: fullname, id: result.user.uid, age: age, profileColor: profileColor)
            loadCurrentUserData()
            
            if let user = self.userSession {
                try await createNewSession(for: user.uid)
            }
            
        } catch {
            
            throw error
        }
    }
    
    func sendVerificationCode() {
        Auth.auth().languageCode = "en"  // Укажите нужный вам язык
        Auth.auth().currentUser?.sendEmailVerification { error in
//            if let error {
//                message = "Error: \(error.localizedDescription)"
//            } else {
//                message = "Verification email sent."
//            }
        }
    }

    func createNewPartner(partnerId: String, currentUserID: String) async throws {
        do {
            let partnerData = try await Firestore.firestore().collection("users").document(partnerId).getDocument()
            let user = try partnerData.data(as: User.self)
            guard let encodedUser = try? Firestore.Encoder().encode(user) else { return }
            
            let newPartnerRef = Firestore.firestore()
                .collection("users")
                .document(currentUserID)
                .collection("partners")
                .document(partnerId)
            
            try await newPartnerRef.setData(encodedUser)
        }
    }
    
    func singOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            UserService.shared.currentUser = nil
            
            if #available(iOS 17, *) {
                try? Tips.resetDatastore()
                Tips.showAllTipsForTesting()
            }
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
            throw error
        }
    }
    
    private func loadCurrentUserData() {
        Task {
            try await UserService.shared.fetchCurrentUser()
        }
    }
    
    func deleteUser() {
        let user = Auth.auth().currentUser
        
        user?.delete { error in
            if let error {
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
            let sessionId = session.documentID
            
            let sessionData: [String: Any] = [
                "date": Timestamp(date: Date()),
                "time": Timestamp(date: Date()),
                "blocked": false
            ]
            
            try await sessionsRef.document(sessionId).updateData(sessionData)
        } else {
            try await createNewSession(for: userId)
        }
    }
    
    private func getCurrentIPAddress() -> String {
        "\(Int.random(in: 0...200))"
    }
}
