//
//  MainView.swift
//  Lovly Kids
//
//  Created by Дима Кожемякин on 10.05.2024.
//

import SwiftUI

struct MainView: View {
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        NavigationStack {
            ZStack {
                if colorScheme == .dark {
                    Color.black
                } else {
                    Color("F9F6F1")
                        .ignoresSafeArea(edges: .bottom)
                }
                
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack {
                        Storis()
                            .cornerRadius(35)
                            .frame(width: UIScreen.main.bounds.width, height: 200)
                            .offset(y: colorScheme == .dark ? CGFloat(0) : -38)
                        
                        if colorScheme == .dark {
                            Image("mama-pervoe-slovo-in")
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width - 16, height: 200)
//                                .offset(y: -5)
                        } else {
                            Image("emotional-baggage")
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width - 16, height: 350)
//                                .offset(y: 0)
                        }
                        
                        OftenOrder()
                            .cornerRadius(35)
                            .frame(width: UIScreen.main.bounds.width - 16, height: 300)
                        
                        Achievements()
                            .cornerRadius(35)
                            .frame(width: UIScreen.main.bounds.width - 16, height: 300)
                            .padding()
                    }
                }
            }
            .refreshable {
                do {

                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    MainView()
        .colorScheme(.light)
}
#Preview {
    MainView()
        .colorScheme(.dark)
}
