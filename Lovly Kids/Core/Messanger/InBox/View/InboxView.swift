//
//  InboxView.swift
//  Manager
//
//  Created by Дима Кожемякин on 23.02.2024.
//

import SwiftUI

struct InboxView: View {
    @StateObject private var viewModel = InboxViewModel()
    @EnvironmentObject private var appData: AppData
    
    @State private var showNewMessageView = false
    @State private var selectedUser: User?
    @State private var showChat = false
    
    private var user: User? {
        viewModel.currentUser
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("F9F6F1")
                    .ignoresSafeArea()
                
                List {
                    ForEach(viewModel.recentMessages) { message in
                        ZStack {
                            NavigationLink(value: message) {
                                EmptyView()
                            }.opacity(0.0)
                            
                            InboxRootNew(message: message)
                        }
                    }
                }
                .listStyle(PlainListStyle())
                .navigationDestination(isPresented: $showChat) {
                    if let selectedUser {
                        ChatView(user: selectedUser) {
                            
                        }
                    }
                }
                .navigationDestination(for: Message.self) { message in
                    if let user = message.user {
                        ChatView(user: user) {
                            
                        }
                    }
                }
                .fullScreenCover(isPresented: $showNewMessageView) {
                    NewMessageView(selectedUser: $selectedUser)
                        .environment(\.colorScheme, appData.appearance)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        HStack {
                            Text("Chats")
                                .font(.title)
                                .fontWeight(.semibold)
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showNewMessageView.toggle()
                            self.selectedUser = nil
                        } label: {
                            Image(systemName: "square.and.pencil.circle.fill")
                                .resizable()
                                .frame(width: 32, height: 32)
                                .foregroundStyle(.black, Color(.systemGray5))
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    InboxView()
        .environmentObject(AppData())
}
