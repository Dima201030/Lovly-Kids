//
//  CircularProfileImageView.swift
//  ExamMessager
//
//  Created by Дима Кожемякин on 23.02.2024.
//

import SwiftUI

enum ProfileImageSize {
    case xxSmall
    case xSmall
    case small
    case medium
    case large
    case xLarge
    case max
    
    var dimension: CGFloat {
        switch self {
        case .xxSmall:
            return 28
        case .xSmall:
            return 32
        case .small:
            return 40
        case .medium:
            return 56
        case .large:
            return 64
        case .xLarge:
            return 80
        case .max:
            return 120
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

struct CircularProfileImageView_Preview: PreviewProvider {
    static var previews: some View {
        CircularProfileImageView(user: User.MOCK_USER, size: .max)
    }
}
