//
//  ContentViewModel.swift
//  Manager
//
//  Created by Дима Кожемякин on 23.02.2024.
//

import Combine
import Firebase

class ContentViewModel: ObservableObject {
    @Published var userSession: Firebase.User?
    private var cancellables = Set<AnyCancellable>()
    init() {
        setupSubscribers()
    }
    
    private func setupSubscribers() {
        AuthService.shared.$userSession.sink { [weak self] userSessionFromAuthService in
            self?.userSession = userSessionFromAuthService
        }.store(in: &cancellables)
    }
}
