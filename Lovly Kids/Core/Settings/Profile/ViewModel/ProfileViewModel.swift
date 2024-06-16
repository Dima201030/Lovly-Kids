//
//  ProfileViewModel.swift
//  ExamMessager
//
//  Created by Дима Кожемякин on 23.02.2024.
//

import SwiftUI
import PhotosUI

@available(iOS 17.0, *)
class ProfileViewModel: ObservableObject {
    @Environment(\.colorScheme) private var colorScheme
    
    
    @Published var selectItme: PhotosPickerItem? {
        didSet {
            Task { 
                try await loadImage()
            }
        }
    }
    
    // Инициализируем profileImage пустым значением
    @Published var profileImage: Image? = nil
    
    @Published var averageColor: UIColor? = nil
    
    func loadImage() async throws {
        guard let item = selectItme else { return }
        guard let imageData = try await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: imageData) else { return }
        
        // Получение среднего цвета фрагмента изображения
        let fragmentImage = uiImage.cropToCenter(square: min(uiImage.size.width, uiImage.size.height))
        let averageColour = fragmentImage.getAverageColour
        
        // Выполнить обновление на главном потоке
        DispatchQueue.main.async {
            self.profileImage = Image(uiImage: uiImage)
            self.averageColor = averageColour
        }
    }
}
