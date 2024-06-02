//
//  CircularProfileImageView.swift
//  ExamMessager
//
//  Created by Дима Кожемякин on 23.02.2024.
//

import SwiftUI

enum ProfileImageSize {
    case xxSmall,
         xSmall,
         small,
         medium,
         large,
         xLarge,
         max
    
    var dimension: CGFloat {
        switch self {
        case .xxSmall: 28
        case .xSmall: 32
        case .small: 40
        case .medium: 56
        case .large: 64
        case .xLarge: 80
        case .max: 120
        }
    }
}

struct CircularProfileImageView: View {
    var user: User?
    let size: ProfileImageSize
    
    var body: some View {
        if let imageUrl = user?.profileImageUrl {
            Image(imageUrl)
                .resizable()
                .scaledToFill()
                .frame(width: size.dimension, height: size.dimension)
                .clipShape(Circle())
        } else {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: size.dimension, height: size.dimension)
                .foregroundColor(Color(.systemGray4))
        }
    }
}

#Preview {
    CircularProfileImageView(user: User.MOCK_USER, size: .max)
}
