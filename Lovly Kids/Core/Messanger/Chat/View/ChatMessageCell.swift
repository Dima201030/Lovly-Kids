//
//  ChatMessageView.swift
//  ExamMessager
//
//  Created by Дима Кожемякин on 04.02.2024.
//

import SwiftUI

struct ChatMessageView: View {
    let message: Message
    
    private var isFromCurrnetUser: Bool {
        return message.isFromCurrentUser
    }
    var body: some View {
        HStack {
            if isFromCurrnetUser {
                Spacer()
                
                Text(message.messageText)
                    .font(.subheadline)
                    .padding()
                    .background(Color(.systemBlue))
                    .foregroundColor(.white)
                    .clipShape(ChatBubble(isFromCurrentUser: isFromCurrnetUser))
                    .frame(maxWidth: UIScreen.main.bounds.width / 1.5, alignment: .trailing)
            } else {
                HStack(alignment: .bottom, spacing: 8) {
                    CircularProfileImageView(user: User.MOCK_USER, size: .xxSmall)
                    Text(message.messageText)
                        .font(.subheadline)
                        .padding()
                        .background(Color(.systemGray5))
                        .foregroundColor(.black)
                        .clipShape(ChatBubble(isFromCurrentUser: isFromCurrnetUser))
                        .frame(maxWidth: UIScreen.main.bounds.width / 1.75, alignment: .leading)

                    Spacer()
                }
            }
        }
        .padding(.horizontal, 8)
    }
}
//
//#Preview {
//    ChatMessageView(isFromCurrentUser: false)
//}
