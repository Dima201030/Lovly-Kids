//
//  ChangeLaungeEnum.swift
//  Lovly Kids
//
//  Created by Дима Кожемякин on 09.05.2024.
//

import Foundation
enum ChangeLaungeEnum: Int, CaseIterable, Identifiable {
    case en
    case ru
    
    var title: String {
        switch self {
        case .en:
            return "English"
        case .ru:
            return "Russian"
        }
    }
    var abbreviation: String {
        switch self {
        case .en:
            return "en"
        case .ru:
            return "ru"
        }
    }
    var id: Int { return self.rawValue }
}
