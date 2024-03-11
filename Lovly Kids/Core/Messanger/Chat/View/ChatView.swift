//
//  ChatView.swift
//  ExamMessager
//
//  Created by Дима Кожемякин on 03.02.2024.
//

import SwiftUI

struct ChatView: View {
    @StateObject var viewModel: ChatViewModel
    let user: User
    
    init(user: User) {
        self.user = user
        self._viewModel = StateObject(wrappedValue: ChatViewModel(user: user))
    }
    var body: some View {
        ScrollView {
            // header
            VStack {
                CircularProfileImageView(user: user, size: .xLarge)
                
                VStack(spacing: 4) {
                    Text(user.fullname)
                        .font(.title3)
                        .fontWeight(.semibold)
                    Text("Messager")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
            }
            // messages
            
            ForEach(viewModel.messages) { message in
                ChatMessageView(message: message)
                    
            }
            
        }
        
        
        
        Spacer()
        ZStack(alignment: .trailing) {
            TextField("Message..." , text: $viewModel.messageText, axis: .vertical)
                .padding(12)
                .padding(.trailing, 48)
                .background(Color(.systemGroupedBackground))
                .clipShape(Capsule())
                .font(.subheadline)
            Button {
                viewModel.sendMessage()
                viewModel.messageText = ""
            } label: {
                Text("Send")
                    .font(.subheadline)
            }
            .padding(.horizontal)

        }
        .padding()
    }
}

#Preview {
    ChatView(user: User.MOCK_USER)
}
