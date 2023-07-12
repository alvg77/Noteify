//
//  RegisterViewModel.swift
//  StamSoftProizvodstvena
//
//  Created by Aleko Georgiev on 7.07.23.
//

import Foundation

class RegisterViewModel {
    private static let passRegex = /^.*(?=.{6,})(?=.*[A-Z])(?=.*[a-zA-Z])(?=.*\\d)|(?=.*[!#$%&? "]).*$/
    
    @Published var email = ""
    @Published var password = ""
    @Published var repeatPassword = ""
    
    func validatePassword() -> Bool {
        return password.wholeMatch(of: RegisterViewModel.passRegex) != nil
    }
    
    func validateRepeatPassword() -> Bool {
        return password == repeatPassword
    }
}
