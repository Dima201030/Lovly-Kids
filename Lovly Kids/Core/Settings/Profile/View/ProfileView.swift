//
//  ProfileView.swift
//  Manager
//
//  Created by Дима Кожемякин on 23.02.2024.
//

import SwiftUI
import Firebase
import FirebaseStorage

struct ProfileView: View {
    let user: User?
    
    var body: some View {
        if #available(iOS 17, *) {
            ProfileView17(user: user!)
        } else if #available(iOS 16, *) {
            ProfileView15(user: user!)
        } else {
            ProfileView15(user: user!)
        }
    }
}
