//
//  WrongCredentialsError.swift
//  StamSoftProizvodstvena
//
//  Created by Aleko Georgiev on 11.07.23.
//

import Foundation

enum AuthenticationError: Error {
    case invalidEmail
    case invalidPassword
    case unknown
    
    var errorDescription: String {
        switch self {
        case .invalidEmail:
            return "Email does not exist."
        case .invalidPassword:
            return "Email and password do not match."
        case .unknown:
            return "Unknown error occured."
        }
    }
}
