//
//  Gradients.swift
//  ShopOp
//
//  Created by Дима Кожемякин on 14.03.2024.
//

import SwiftUI

struct AnimatedRadialGradient: View {
    @State private var yOffset = -100.0
    
    private let colors: [Color]
    private let startPoint: UnitPoint
    private let endPoint: UnitPoint
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.clear)
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
        .zIndex(-1)
    }
}
