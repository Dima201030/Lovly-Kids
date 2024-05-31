//
//  MainView.swift
//  Lovly Kids
//
//  Created by Дима Кожемякин on 10.05.2024.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                
                Color("F9F6F1")
                    .ignoresSafeArea(edges: .bottom)
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack {
                        Storis()
                            .cornerRadius(35)
                            .frame(width: UIScreen.main.bounds.width - 16, height: 200)
                            .offset(y: -38)
                        
                        Image("emotional-baggage")
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width - 16, height: 350)
                            .offset(y: 0)
                        
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
                    print("Refresh")
                }
            }
            .navigationTitle("House")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    MainView()
}
