//
//  LoginModel.swift
//  StamSoftProizvodstvena
//
//  Created by Aleko Georgiev on 12.07.23.
//

import Foundation

struct LoginModel {
    
    
    var currentUser: User?

    mutating func login(_ user: User) {
        currentUser = user
    }
}
