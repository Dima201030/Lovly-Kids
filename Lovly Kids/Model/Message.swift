//
//  Message.swift
//  Lovly Kids
//
//  Created by Дима Кожемякин on 29.02.2024.
//

import Firebase
import FirebaseFirestoreSwift

struct Message: Identifiable, Codable, Hashable {
    @DocumentID var messageId: String?
    
    let fromId: String
    let toId: String
    var messageText: String
    let timestamp: Timestamp
    let keyShifr: Int
    
    var user: User?
    
    var id: String {
        messageId ?? NSUUID().uuidString
    }
    
    var chatPartnerId: String {
        fromId == Auth.auth().currentUser?.uid ? toId : fromId
    }
    
    var isFromCurrentUser: Bool {
        fromId == Auth.auth().currentUser?.uid
    }
    
    var timestampString: String {
        timestamp.dateValue().timestampString()
    }
}
