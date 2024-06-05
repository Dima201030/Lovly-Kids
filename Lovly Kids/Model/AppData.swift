//
//  AppData.swift
//  Lovly Kids
//
//  Created by Дима Кожемякин on 09.05.2024.
//

import SwiftUI

class AppData: ObservableObject {
    @Published var appearance: ColorScheme = .light
    @Published var language: Locale = .autoupdatingCurrent
    
    init() {
        self.appearance = getColorScheme()
        self.language = getLanguage()
    }
    
    func saveLanguage(language: String) {
        let defaults = UserDefaults.standard
        defaults.set(language, forKey: "language")
        self.language = Locale(identifier: language)
    }
    
    func getLanguage() -> Locale {
        let defaults = UserDefaults.standard
        
        if let rawValue = defaults.string(forKey: "language") {
            print("DEBUG: \(rawValue)")
            return Locale(identifier: rawValue)
        } else {
            return .autoupdatingCurrent
        }
    }
    
    func saveColorScheme() {
        let defaults = UserDefaults.standard
        defaults.set(appearance == .dark ? "dark" : "light", forKey: "colorScheme")
    }
    
    private func getColorScheme() -> ColorScheme {
        let defaults = UserDefaults.standard
        
        if let rawValue = defaults.string(forKey: "colorScheme") {
            return rawValue == "dark" ? .dark : .light
        } else {
            return .light
        }
    }
}
