//
//  ChatViewModel.swift
//  Lovly Kids
//
//  Created by Дима Кожемякин on 29.02.2024.
//

import Foundation

class ChatViewModel: ObservableObject {
    @Published var messageText = ""
    @Published var messages = [Message]()
    
    let service: ChatService
    
    init(user: User){
        self.service = ChatService(chatPartner: user)
        observeMessage()
    }
    func observeMessage() {
        service.observeMessage() { messages in
            DispatchQueue.main.async {
                self.messages.append(contentsOf: messages)
            }
        }
    }
    func sendMessage() {
        service.sendMessage(messageText)    }
}
