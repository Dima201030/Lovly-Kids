//
//  Gradients.swift
//  ShopOp
//
//  Created by Дима Кожемякин on 14.03.2024.
//

import Foundation
import SwiftUI

struct AnimatedRadialGradient: View {
    @State private var yOffset: CGFloat = -100
    
    let colors: [Color]
    let startPoint: UnitPoint
    let endPoint: UnitPoint
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.clear)
                .onAppear {
                    self.yOffset = 300
                }
            
            RadialGradient(gradient: Gradient(colors: colors), center: .center, startRadius: 5, endRadius: 400)
                .scaleEffect(2)
                .offset(x: 0, y: yOffset)
                .animation(
                    Animation.easeInOut(duration: 2)
                        .repeatForever(autoreverses: true)
                )
        }
        .zIndex(-1) // Помещаем на задний план
    }
}
