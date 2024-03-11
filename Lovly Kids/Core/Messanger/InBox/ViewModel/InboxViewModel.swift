//
//  InboxViewModel.swift
//  Manager
//
//  Created by Дима Кожемякин on 26.02.2024.
//

import Foundation
import Combine
import Firebase

class InboxViewModel: ObservableObject {
    @Published var currentUser: User?
    @Published var recentMessages = [Message]()
    
    private var cancellables = Set<AnyCancellable>()
    private let service = InboxService()
    
    init() {
        settupSubscribers()
        service.observeRecentMessages()
    }
    
    private func settupSubscribers() {
        UserService.shared.$currentUser.sink { [weak self] user in
            self?.currentUser = user
        }.store(in: &cancellables)
        service.$documentChanges.sink{ [weak self] changes in
            self?.loadInitialMessage(fromChanes: changes)
        }.store(in: &cancellables)
    }
    private func loadInitialMessage(fromChanes chanes: [DocumentChange]) {
        var messages = chanes.compactMap({ try? $0.document.data(as: Message.self)})
        
        for i in 0 ..< messages.count {
            let message = messages[i]
            
            UserService.fetchUser(withUid: message.chatPartnerId) { user in
                messages[i].user = user
                self.recentMessages.append(messages[i])
            }
        }
    }
}
