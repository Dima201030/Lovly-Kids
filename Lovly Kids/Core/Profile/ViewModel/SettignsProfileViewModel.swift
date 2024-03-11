//
//  SettignsProfileViewModel.swift
//  Lovly Kids
//
//  Created by Дима Кожемякин on 05.03.2024.
//

import Foundation

class SettignsProfileViewModel: ObservableObject {
    
}

enum SettingsProfileEnum: Int, CaseIterable, Identifiable {
    
    case privacy
    
    var title: String {
        switch self {
        case .privacy:
            return "Privacy"
        }
    }
    
    var imageUrl: String {
        switch self {
        case .privacy:
            return "lock.fill"
        }
    }
    var id: Int { return self.rawValue }

}
