//
//  RegistrationError.swift
//  StamSoftProizvodstvena
//
//  Created by Aleko Georgiev on 14.07.23.
//

import Foundation

enum RegistrationError: Error {
    case accountWithEmailExists
    case invalidEmail
    case unknown
    
    var errorDescription: String {
        switch self {
        case .accountWithEmailExists:
            return "An account with this email already exists!"
        case .invalidEmail:
            return "The provided email is invalid"
        case .unknown:
            return "An unknown error occured."
        }
    }
}
