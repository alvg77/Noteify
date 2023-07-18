//
//  FakeAuthenticator.swift
//  StamSoftProizvodstvena
//
//  Created by Aleko Georgiev on 11.07.23.
//

import Foundation
import Combine

struct FakeAuthenticator: Authenticator {
    
    func login(_ credentials: Credentials) -> AnyPublisher<User, AuthenticationError> {
        return Future<User, AuthenticationError> { promise in
            DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
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
        .eraseToAnyPublisher()
    }
    
//    func register(_ credentials: Credentials) async throws -> User {
//        return User(email: "", password: "")
//    }
}
