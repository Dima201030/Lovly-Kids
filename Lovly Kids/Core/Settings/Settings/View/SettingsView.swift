//
//  SettingsView.swift
//  Lovly Kids
//
//  Created by Дима Кожемякин on 29.02.2024.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        if #available(iOS 17, *) {
            SettingsView17()
        } else if #available(iOS 16, *) {
            SettingsView16()
        } else {
            SettingsView15()
        }
    }
}
