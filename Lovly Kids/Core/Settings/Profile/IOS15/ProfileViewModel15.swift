//
//  ProfileViewModel15.swift
//  Lovely Kids
//
//  Created by Дима Кожемякин on 14.06.2024.
//

import SwiftUI
import PhotosUI

class ProfileViewModel15: ObservableObject {
    @Environment(\.colorScheme) private var colorScheme
    
    // Инициализируем profileImage пустым значением
    @Published var profileImage: Image? = nil
    
    @Published var averageColor: UIColor? = nil
    
//    func loadImage() async throws {
//        guard let item = selectItme else { return }
//        guard let imageData = try await item.loadTransferable(type: Data.self) else { return }
//        guard let uiImage = UIImage(data: imageData) else { return }
//        
//        // Получение среднего цвета фрагмента изображения
//        let fragmentImage = uiImage.cropToCenter(square: min(uiImage.size.width, uiImage.size.height))
//        let averageColour = fragmentImage.getAverageColour
//        
//        // Выполнить обновление на главном потоке
//        DispatchQueue.main.async {
//            self.profileImage = Image(uiImage: uiImage)
//            self.averageColor = averageColour
//        }
//    }
}
