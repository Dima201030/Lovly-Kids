//
//  UserProfileView.swift
//  Lovely Kids
//
//  Created by Дима Кожемякин on 07.06.2024.
//

import SwiftUI

struct UserProfileView: View {
    @EnvironmentObject var viewModel: UserProfileViewModel
    var body: some View {
        Text("\(viewModel.userFullname)")
        Text("\(viewModel.userAge)")
        Text("\(viewModel.userUid)")
        Text("\(viewModel.userProfileUrl)")
        Text("\(viewModel.userProfileColor)")
    }
}

#Preview {
    UserProfileView()
        .environmentObject(UserProfileViewModel())
}
