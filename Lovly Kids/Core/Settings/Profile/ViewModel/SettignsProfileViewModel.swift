//
//  SettignsProfileViewModel.swift
//  Lovly Kids
//
//  Created by Дима Кожемякин on 05.03.2024.
//

import Foundation

//class SettignsProfileViewModel: ObservableObject {
//    
//}

enum SettingsProfileEnum: Int {
    case privacy
    
    var title: String {
        switch self {
        case .privacy: "Privacy"
        }
    }
    
    var imageUrl: String {
        switch self {
        case .privacy: "lock.fill"
        }
    }
    
    var id: Int {
        self.rawValue
    }
}
