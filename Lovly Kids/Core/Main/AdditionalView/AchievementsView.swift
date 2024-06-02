//
//  Achievements.swift
//  Lovely Kids
//
//  Created by Дима Кожемякин on 20.05.2024.
//

import SwiftUI

struct Achievements: View {
    var body: some View {
        ZStack {
            Color.white
            
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
