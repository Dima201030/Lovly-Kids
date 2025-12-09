//
//  TextField.swift
//  Lovely Kids
//
//  Created by Дима Кожемякин on 09.12.2025.
//

import SwiftUI

struct BasicTextField: View {
    var placeholder: String
    @Binding var text: String
    var isSecure: Bool = false
    var keyboard: UIKeyboardType = .default
    
    var body: some View {
        HStack {
            if isSecure {
                SecureField(placeholder, text: $text)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .keyboardType(keyboard)
                    .padding(12)
            } else {
                TextField(placeholder, text: $text)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .keyboardType(keyboard)
                    .padding(12)
            }
        }
        .glassEffect(.regular.interactive())
    }
}
