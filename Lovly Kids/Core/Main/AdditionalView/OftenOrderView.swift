//
//  OftenOrder.swift
//  Lovely Kids
//
//  Created by Дима Кожемякин on 20.05.2024.
//

import SwiftUI

struct OftenOrder: View {
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        ZStack {
            if colorScheme == .dark {
                Color(.systemGray6)
            } else {
                Color.white
            }
            
            VStack(alignment: .leading) {
                
                Text("The often order")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .padding()
                
                HStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack{
                            ForEach(OftenOrderEnum.allCases, id: \.self) { options in
                                ZStack {
                                    options.backrounColor
                                    VStack {
                                        Text("\(options.title)")
                                            .foregroundColor(.black)
                                            .fontWeight(.medium)
                                            .multilineTextAlignment(.center)
                                        Spacer()
                                    }
                                    .padding()
                                }
                                
                                .frame(width: 100, height: 120)
                                .cornerRadius(25)
                                .padding(10)
                            }
                        }
                    }
                    Spacer()
                }
                Spacer()
            }
            
        }
        
    }
}

#Preview {
    OftenOrder()
}
