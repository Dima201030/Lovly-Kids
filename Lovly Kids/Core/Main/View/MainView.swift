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
                            .frame(width: UIScreen.main.bounds.width, height: 200)
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
struct Storis: View {
    var body: some View {
        ZStack {
            Color.white
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack{
                    ForEach(MainEnum.allCases, id: \.self) { options in
                        ZStack {
                            options.backrounColor
                            Image("\(options.imageUrl)")
                                .resizable()
                            
                            Text("\(options.title)")
                                .multilineTextAlignment(.center)
                            
                        }
                        .cornerRadius(25)
                        .frame(width: 100, height: 100)
                        .padding(2)
                    }
                    
                }
            }
        }
    }
}
struct OftenOrder: View {
    var body: some View {
        ZStack {
            Color.white
            
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
                                        
                                            .fontWeight(.medium)
                                            .multilineTextAlignment(.center)
                                        Spacer()
                                    }
                                    .padding()
                                }
                                
                                .frame(width: 100, height: 120)
                                .cornerRadius(25)
                                .padding(2)
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

struct Achievements: View {
    var body: some View {
        ZStack {
            Color.white
            
            VStack {
                HStack{
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
    MainView()
}
