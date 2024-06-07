//
//  UserProfileViewModel.swift
//  Lovely Kids
//
//  Created by Дима Кожемякин on 07.06.2024.
//

import SwiftUI

class UserProfileViewModel: ObservableObject {
    @Published var userFullname = "Дмитрий"
    @Published var userAge = 15
    @Published var userUid = "вфлоиазловипщжцL"
    @Published var userProfileUrl = "https://firebasestorage.googleapis.com:443/v0/b/messanger-8c488.appspot.com/o/images%2F530FB321-D960-49E2-A5D8-2887F31D47D1.jpg?alt=media&token=c3e12585-4410-490b-becd-2efee0446d4b"
    @Published var userProfileColor = Color.blue
    
}
