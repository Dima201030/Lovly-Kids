//
//  ProfileViewModel.swift
//  ExamMessager
//
//  Created by Дима Кожемякин on 23.02.2024.
//

import Foundation
import SwiftUI
import PhotosUI

class ProfileViewModel: ObservableObject {

    @Published var selectItme: PhotosPickerItem? {
        didSet { Task { try await loadImage() }}
    }
    @Published var profileImage: Image?
    
    func loadImage() async throws {
        guard let item = selectItme else { return }
        guard let imageData = try await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: imageData) else { return }
        self.profileImage = Image(uiImage: uiImage)
        
    }
}
