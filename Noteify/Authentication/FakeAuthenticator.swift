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
        return Future() { promise in
            DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
                if credentials.email != "a@a.a" {
                    promise(Result.failure(AuthenticationError.invalidEmail))
                }
                
                if credentials.password != "pass" {
                    promise(Result.failure(AuthenticationError.invalidPassword))
                }
                
                promise(Result.success(User(email: credentials.email, password: credentials.password)))
            }
        }
        .eraseToAnyPublisher()
    }
    
//    func register(_ credentials: Credentials) async throws -> User {
//        return User(email: "", password: "")
//    }
}
