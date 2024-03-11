//
//  Constants.swift
//  Lovly Kids
//
//  Created by Дима Кожемякин on 29.02.2024.
//

import Foundation
import Firebase

struct FirestoreConstants {
    static let UserCollection = Firestore.firestore().collection("users")
    static let MessagesCollection = Firestore.firestore().collection("messages")
}
