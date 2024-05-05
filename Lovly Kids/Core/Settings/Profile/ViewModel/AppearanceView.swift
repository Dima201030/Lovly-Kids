//
//  AppeaanceView.swift
//  Lovly Kids
//
//  Created by Дима Кожемякин on 05.03.2024.
//

import SwiftUI

struct AppearanceView: View {
    @EnvironmentObject var appData: AppData
    @State private var showAlert = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Toggle(isOn: Binding<Bool>(
                    get: {
                        return appData.appearance == .dark
                    },
                    set: { newValue in
                        appData.appearance = newValue ? .dark : .light
                        appData.saveColorScheme()
                        showAlert.toggle()
                    }
                )) {
                    Text("Dark appearance")
                }
                .padding()
                
                Button(action: {
                    toggleSystemTheme()
                }, label: {
                    Text("Toggle System Theme")
                })
                .padding()
                
                Text("Current color scheme: \(appData.appearance == .dark ? "Dark" : "Light")")
                    .padding()
            }
        }
    }
    
    private func toggleSystemTheme() {
        // Toggle between light and dark modes
        let newAppearance = appData.appearance == ColorScheme.dark ? ColorScheme.light : ColorScheme.dark
        appData.appearance = newAppearance
        appData.saveColorScheme()
        
        // Show alert to restart the app
        showAlert.toggle()
    }

}

struct AppearanceView_Previews: PreviewProvider {
    static var previews: some View {
        AppearanceView()
            .environmentObject(AppData())
    }
}
