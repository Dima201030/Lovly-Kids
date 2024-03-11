//
//  AppeaanceView.swift
//  Lovly Kids
//
//  Created by Дима Кожемякин on 05.03.2024.
//

import SwiftUI

struct AppearanceView: View {
    @EnvironmentObject var appData: AppData

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
                    }
                )) {
                    Text("Dark appearance")
                }
                .padding()
                
                Text("Current color scheme: \(appData.appearance == .dark ? "Dark" : "Light")")
                    .padding()
            }
        }
    }
}

struct AppearanceView_Previews: PreviewProvider {
    static var previews: some View {
        AppearanceView()
            .environmentObject(AppData())
    }
}
