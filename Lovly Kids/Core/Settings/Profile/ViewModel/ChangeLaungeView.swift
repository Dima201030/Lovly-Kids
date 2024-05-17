//
//  ChangeLaungeView.swift
//  Lovly Kids
//
//  Created by Дима Кожемякин on 09.05.2024.
//

import SwiftUI

struct ChangeLaungeView: View {
    @EnvironmentObject var appData: AppData
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(ChangeLaungeEnum.allCases, id: \.self){options in
                        Button {
                            appData.saveLanguage(launge: "\(options.abbreviation)")
                        } label: {
                            Text("\(options.title)")
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
