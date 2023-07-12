//
//  LoginCredentialsAuthStatus.swift
//  StamSoftProizvodstvena
//
//  Created by Aleko Georgiev on 11.07.23.
//

import Foundation

enum ProgressStatus {
    case idle
    case inProgress
    
    mutating func toggle() {
        switch self {
        case .idle:
            self = .inProgress
        case .inProgress:
            self = .idle
        }
    }
}
