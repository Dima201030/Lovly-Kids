//
//  LoginWithPhone.swift
//  Lovly Kids
//
//  Created by Дима Кожемякин on 17.05.2024.
//

import Foundation

class LoginWithPhoneViewModel: ObservableObject {
    @Published var phone = ""
    @Published var countryNumber = ""
    @Published var code = ""
}



