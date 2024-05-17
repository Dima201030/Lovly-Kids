//
//  MainEnum.swift
//  Lovly Kids
//
//  Created by Дима Кожемякин on 10.05.2024.
//

import Foundation
import SwiftUI

enum MainEnum: Int, CaseIterable, Identifiable {
    case how
    case you
    case sale
    case podbor
    
    var imageUrl: String {
        switch self {
        case .how:
            return ""
        case .you:
            return "Ты это важно"
        case .sale:
            return "Скидки"
        case .podbor:
            return "Специалист"
        }
    }
    var title: String {
        switch self {
        case .how:
            return "Как кошки влияют на детей 🤔"
        case .you:
            return ""
        case .sale:
            return ""
        case .podbor:
            return ""
        }
    }
    var backrounColor: Color {
        switch self {
        case .how:
            return Color("D3A58C")
        case .you:
            return Color.white
        case .sale:
            return Color.white
        case .podbor:
            return Color.white
        }
    }
    var id: Int { return self.rawValue }
}
enum OftenOrderEnum: Int, CaseIterable, Identifiable {
    case Tanya
    case Maria
    case Katya
    case Lera
    
//    var imageUrl: String {
//        switch self {
//        case .Tanya:
//
//        case .Maria:
//
//        case .Katya:
//
//        case .Lera:
//
//        }
//    }
    var title: String {
        switch self {
        case .Tanya:
            return "Татьяна Теришкова"
        case .Maria:
            return "Мария Переносова"
        case .Katya:
            return "Катя Простосёлова"
        case .Lera:
            return "Лера Степанова"
        }
    }
    var backrounColor: Color {
        switch self {
        case .Tanya:
            Color("EED8B7")
        case .Maria:
            Color("D3A58C")
        case .Katya:
            Color("F9F6F1")
        case .Lera:
            Color("FFF1E6")
        }
    }
    var id: Int { return self.rawValue }
}
