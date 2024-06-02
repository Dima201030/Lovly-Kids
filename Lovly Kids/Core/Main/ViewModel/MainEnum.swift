//
//  MainEnum.swift
//  Lovly Kids
//
//  Created by Дима Кожемякин on 10.05.2024.
//

import SwiftUI

enum MainEnum: Int, CaseIterable, Identifiable {
    case how
    case you
    case sale
    case podbor
    
    var imageUrl: String {
        switch self {
        case .how: ""
        case .you: "Ты это важно"
        case .sale: "Скидки"
        case .podbor: "Специалист"
        }
    }
    
    var title: String {
        switch self {
        case .how: "Как кошки влияют на детей 🤔"
        case .you: ""
        case .sale: ""
        case .podbor: ""
        }
    }
    
    var backrounColor: Color {
        switch self {
        case .how: Color("D3A58C")
        case .you: .white
        case .sale: .white
        case .podbor: .white
        }
    }
    
    var id: Int {
        self.rawValue
    }
    
}

enum OftenOrderEnum: Int, CaseIterable, Identifiable {
    case Tanya,
         Maria,
         Katya,
         Lera
    
    var title: String {
        switch self {
        case .Tanya: "Татьяна Теришкова"
        case .Maria: "Мария Переносова"
        case .Katya: "Катя Простосёлова"
        case .Lera: "Лера Степанова"
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
    
    var id: Int {
        self.rawValue
    }
}
