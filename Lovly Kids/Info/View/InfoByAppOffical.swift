//
//  InfoByAppOff.swift
//  Lovly Kids
//
//  Created by Дима Кожемякин on 04.03.2024.
//

import SwiftUI

struct InfoByAppOffical: View {
    @StateObject var viewModel = InfoViewModelTexts()
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Text("ООО «LOVLYKIDS»")
                    Spacer()
                    Text("Firebase version: \(viewModel.versionFirebase)")
                }
            }
            .navigationTitle("Info")
        }
    }
}

#Preview {
    InfoByAppOffical()
}
