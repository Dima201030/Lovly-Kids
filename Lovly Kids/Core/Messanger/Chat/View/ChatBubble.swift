//
//  ChatBubble.swift
//  ExamMessager
//
//  Created by Дима Кожемякин on 04.02.2024.
//

import SwiftUI

struct ChatBubble: Shape {
    let isFromCurrentUser: Bool
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [
            .topLeft,
            .topRight,
            isFromCurrentUser ? .bottomLeft : .bottomRight
            
        ], cornerRadii: CGSize(width: 20, height: 20))
        return Path(path.cgPath)
        
    }
}

#Preview {
    ChatBubble(isFromCurrentUser: true)
}
