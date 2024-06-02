//
//  IntExtension.swift
//  Lovly Kids
//
//  Created by Дима Кожемякин on 02.05.2024.
//

import SwiftUI

extension Int {
    func formattedWithSeparator() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: self)) ?? ""
    }
}
