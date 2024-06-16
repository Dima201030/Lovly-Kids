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
        case .en: "English"
        case .ru: "Russian"
        }
    }
    var abbreviation: String {
        switch self {
        case .en: "en"
        case .ru: "ru"
        }
    }
    
    var id: Int {
        self.rawValue
    }
}
