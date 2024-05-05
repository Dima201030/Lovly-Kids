//
//  User.swift
//  Manager
//
//  Created by Дима Кожемякин on 23.02.2024.
//

import Foundation
import FirebaseFirestoreSwift
import SwiftUI

struct User: Codable, Identifiable, Hashable {
    
    @DocumentID var uid: String?
    var fullname: String
    let email: String
    var age: Int
    var profileImageUrl: String?
    var profileColorString: String // Changed to String
    
    var id: String {
        return uid ?? NSUUID().uuidString
    }
    
    var profileColor: Color { // Convert String color to Color
        return Color(profileColorString)
    }
}

class AppData: ObservableObject {
    @Published var appearance: ColorScheme = .light
    
    init() {
        self.appearance = getColorScheme()
    }
    
    func saveColorScheme() {
        let defaults = UserDefaults.standard
        defaults.set(appearance == .dark ? "dark" : "light", forKey: "colorScheme")
    }
    
    private func getColorScheme() -> ColorScheme {
        let defaults = UserDefaults.standard
        if let rawValue = defaults.string(forKey: "colorScheme") {
            return rawValue == "dark" ? .dark : .light
        } else {
            return .light
        }
    }
}

extension User {
    static let MOCK_USER = User(fullname: "Saha", email: "Saha@gmail.com", age: 25, profileImageUrl: "Saha", profileColorString: "blue") // Added profileColorString
}
