//
//  Storis.swift
//  Lovely Kids
//
//  Created by Дима Кожемякин on 20.05.2024.
//

import SwiftUI

struct Storis: View {
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        ZStack {
            if colorScheme == .dark {
                Color(.systemGray6)
            } else {
                Color.white
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(MainEnum.allCases, id: \.self) { options in
                        ZStack {
                            options.backrounColor
                            
                            Image(options.imageUrl)
                                .resizable()
                            
                            Text(options.title)
                                .multilineTextAlignment(.center)
                            
                        }
                        .cornerRadius(25)
                        .frame(width: 100, height: 100)
                        .padding(8)
                    }
                }
            }
        }
    }
}

#Preview {
    Storis()
}
