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
    
    func saveLanguage(launge: String) {
        let defaluts = UserDefaults.standard
        defaluts.set(language == .autoupdatingCurrent ? "automatic" : "en", forKey: "language")
    }
    
    func getLanguage() -> Locale {
        let defaluts = UserDefaults.standard
        
        if let rawValue = defaluts.string(forKey: "language") {
            print("DEBUG: \(rawValue)")
            return rawValue == "automatic" ? .init(identifier: "\(rawValue)") : .autoupdatingCurrent
        } else {
            let rawValue = defaluts.string(forKey: "language")
            print("DEBUG: \(rawValue)")
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
