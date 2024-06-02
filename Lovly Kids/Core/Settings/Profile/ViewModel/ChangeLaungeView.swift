//
//  ChangeLaungeView.swift
//  Lovly Kids
//
//  Created by Дима Кожемякин on 09.05.2024.
//

import SwiftUI

struct ChangeLaungeView: View {
    @EnvironmentObject private var appData: AppData
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(ChangeLaungeEnum.allCases, id: \.self) { options in
                        Button(options.title) {
                            appData.saveLanguage(launge: options.abbreviation)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ChangeLaungeView()
        .environmentObject(AppData())
}
