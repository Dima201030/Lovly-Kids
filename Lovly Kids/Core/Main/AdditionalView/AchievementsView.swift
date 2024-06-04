//
//  Achievements.swift
//  Lovely Kids
//
//  Created by Дима Кожемякин on 20.05.2024.
//

import SwiftUI

struct Achievements: View {
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        ZStack {
            if colorScheme == .dark {
                Color(.systemGray6)
            } else {
                Color.white
            }
            
            VStack {
                HStack {
                    Text("There are 31659 nannies in total!")
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .padding()
                    
                    Spacer()
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    Achievements()
}
