//
//  ChatService.swift
//  Lovly Kids
//
//  Created by Дима Кожемякин on 29.02.2024.
//

import Foundation
import Firebase

struct ChatService {

    
    let chatPartner: User
    
    func sendMessage(_ messageText: String) {
        guard let currnetUid = Auth.auth().currentUser?.uid else { return }
        
        let chatPaternId = chatPartner.id
        
        let currentUserRef = FirestoreConstants.MessagesCollection.document(currnetUid).collection(chatPaternId).document()
        let chatPartnerRef = FirestoreConstants.MessagesCollection.document(chatPaternId).collection(currnetUid)
        
        let recentCurrentUserRef = FirestoreConstants.MessagesCollection.document(currnetUid).collection("recent-messages").document(chatPaternId)
        let recentPartnerRef = FirestoreConstants.MessagesCollection.document(chatPaternId).collection("recent-messages").document(currnetUid)
        
        let messageId = currentUserRef.documentID
        
        let message = Message(
            messageId: messageId,
            fromId: currnetUid,
            toId: chatPaternId,
            messageText: messageText,
            timestamp: Timestamp()
        )
        guard let messageData = try? Firestore.Encoder().encode(message) else { return }
        
        currentUserRef.setData(messageData)
        chatPartnerRef.document(messageId).setData(messageData)
        
        recentCurrentUserRef.setData(messageData)
        recentPartnerRef.setData(messageData)

    }
    
    func observeMessage(completion: @escaping([Message]) -> Void) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        let chatPartnerId = chatPartner.id
        
        let query = FirestoreConstants.MessagesCollection
            .document(currentUid)
            .collection(chatPartnerId)
            .order(by: "timestamp", descending: false)
        
        query.addSnapshotListener { snapshot, _ in
            guard let changes = snapshot?.documentChanges.filter({ $0.type == .added }) else { return }
            var messages = changes.compactMap({ try? $0.document.data( as: Message.self ) } )
            
            for (index, message) in messages.enumerated() where message.fromId != currentUid {
                messages[index].user = chatPartner
            }
            
            completion(messages)
        }
    }
}
