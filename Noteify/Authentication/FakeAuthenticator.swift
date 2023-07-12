//
//  FakeAuthenticator.swift
//  StamSoftProizvodstvena
//
//  Created by Aleko Georgiev on 11.07.23.
//

import Foundation
import Combine

struct FakeAuthenticator: Authenticator {
    
    func login(_ credentials: Credentials) -> Future<User, AuthenticationError> {
        return Future<User, AuthenticationError> { promise in
            DispatchQueue.global().async {
                if credentials.email != "a@a.a" {
                    debugPrint("Invalid email")
                    promise(.failure(AuthenticationError.invalidEmail))
                    return
                }
                
                if credentials.password != "pass" {
                    debugPrint("Invalid password")
                    promise(.failure(AuthenticationError.invalidPassword))
                    return
                }
                
                debugPrint("Authentication success")
                promise(.success(User(id: 1, email: credentials.email)))
            }
        }
    }
    
//    func register(_ credentials: Credentials) async throws -> User {
//        return User(email: "", password: "")
//    }
}
