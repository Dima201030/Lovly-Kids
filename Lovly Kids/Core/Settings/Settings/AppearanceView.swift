//
//  AppeaanceView.swift
//  Lovly Kids
//
//  Created by Дима Кожемякин on 05.03.2024.
//

import SwiftUI

struct AppearanceView: View {
    @EnvironmentObject private var appData: AppData
    @State private var showAlert = false
    
    var body: some View {
        VStack {
            Toggle("Dark appearance", isOn: Binding<Bool>(
                get: {
                    return appData.appearance == .dark
                }, set: { newValue in
                    appData.appearance = newValue ? .dark : .light
                    appData.saveColorScheme()
                    showAlert.toggle()
                }
            ))
            .padding()
            
            Button {
                toggleSystemTheme()
            } label: {
                Text("Toggle System Theme")
            }
            .padding()
            
            Text("Current color scheme: \(appData.appearance == .dark ? "Dark" : "Light")")
                .padding()
        }
        
    }
    
    private func toggleSystemTheme() {
        // Toggle between light and dark modes
        let newAppearance = appData.appearance == .dark ? .light : ColorScheme.dark
        appData.appearance = newAppearance
        appData.saveColorScheme()
        
        // Show alert to restart the app
        showAlert.toggle()
    }
    
}

#Preview {
    AppearanceView()
        .environmentObject(AppData())
}
