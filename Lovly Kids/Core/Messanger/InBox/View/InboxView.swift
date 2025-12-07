//
//  InboxView.swift
//  Manager
//
//  Created by Дима Кожемякин on 23.02.2024.
//

import SwiftUI

struct InboxView: View {
    @State private var showNewMessageView = false
    @StateObject var viewModel = InboxViewModel()
    @State private var selectedUser: User?
    @State private var showChat = false
    @EnvironmentObject var appData: AppData
    @State private var count = 0
    
    private var user: User? {
        return viewModel.currentUser
    }
    
    
    
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                List {
                    ForEach(viewModel.recentMessages) { message in
                        ZStack {
                            NavigationLink(value: message) {
                                EmptyView()
                            }
                            .opacity(0)
                            
                            InboxRootNew(message: message)
                        }
                    }
                }
                .refreshable {
                    viewModel.resetInBox()
                }
                .listStyle(.plain)
                .navigationDestination(isPresented: $showChat) {
                    if let user = selectedUser {
                        ChatView(user: user)
                    }
                }
                .onChange(of: selectedUser) { newValue in
                    showChat = newValue != nil
                }
                .navigationDestination(for: Message.self) { message in
                    if let user = message.user {
                        ChatView(user: user)
                    }
                }
                .sheet(isPresented: $showNewMessageView) {
                    NavigationStack {
                        NewMessageView(selectedUser: $selectedUser)
                            .environment(\.colorScheme, appData.appearance)
                    }
                }
                
                .onAppear {
                    if count != 0 {
                        Task {
                            viewModel.resetInBox()
                        }
                    } else {
                        count = count + 1
                    }
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
