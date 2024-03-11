//
//  InboxRootNew.swift
//  Manager
//
//  Created by Дима Кожемякин on 23.02.2024.
//

import SwiftUI

struct InboxRootNew: View {
    let message: Message
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            CircularProfileImageView(user: message.user, size: .medium)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(message.user?.fullname ?? "")
                    .lineLimit(1)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                Text(message.messageText)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(2)
                    .frame(maxWidth: UIScreen.main.bounds.width - 100, alignment: .leading)
            }
            HStack {
                Text(message.timestampString)
                
                Image(systemName: "chevron.right")
            }
            .font(.footnote)
            .foregroundColor(.gray)
        }
        .frame(height: 72)
    }
}

//#Preview {
//    InboxRootNew()
//}
