//
//  LoginCredentialsAuthStatus.swift
//  StamSoftProizvodstvena
//
//  Created by Aleko Georgiev on 11.07.23.
//

import Foundation

enum LoginCredentialsAuthStatus {
    case idle
    case authenticating
    
    mutating func toggle() {
        switch self {
        case .idle:
            self = .authenticating
        case .authenticating:
            self = .idle
        }
    }
}
