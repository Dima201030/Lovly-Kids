//
//  User.swift
//  Manager
//
//  Created by Дима Кожемякин on 23.02.2024.
//

import SwiftUI
import FirebaseFirestoreSwift

struct User: Codable, Identifiable, Hashable {
    
    @DocumentID var uid: String?
    var fullname: String
    let email: String
    var age: Int
    var profileImageUrl: String
    var profileColorString: String 
    
    var id: String {
        uid ?? NSUUID().uuidString
    }
    
    var profileColor: Color { // Convert String color to Color
        Color(profileColorString)
    }
}

extension User {
    static let MOCK_USER = User(fullname: "Saha", email: "Saha@gmail.com", age: 25, profileImageUrl: "Saha", profileColorString: "blue") // Added profileColorString
}
