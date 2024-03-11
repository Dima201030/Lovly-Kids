//
//  ViewModel.swift
//  Lovly Kids
//
//  Created by Дима Кожемякин on 04.03.2024.
//

import Foundation
import Firebase

class InfoViewModelTexts: ObservableObject {
    @Published var versionFirebase = Firebase.FirebaseVersion()
}
