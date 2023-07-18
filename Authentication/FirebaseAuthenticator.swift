//
//  FirebaseAuthenticator.swift
//  StamSoftProizvodstvena
//
//  Created by Aleko Georgiev on 17.07.23.
//

import Foundation
import Combine
import Firebase
import FirebaseAuth

struct FirebaseAuthenticator: Authenticator {
    
    func login(_ credentials: Credentials) -> AnyPublisher<User, AuthenticationError> {
        Future<User, AuthenticationError> { promise in
            Auth.auth().signIn(withEmail: credentials.email, password: credentials.password) { result, error in
                debugPrint("hiiiiii")
                if let error = error as? NSError {
                    switch error.code {
                    case AuthErrorCode.userNotFound.rawValue:
                        promise(.failure(AuthenticationError.invalidEmail))
                    case AuthErrorCode.wrongPassword.rawValue:
                        promise(.failure(AuthenticationError.invalidPassword))
                    default:
                        promise(.failure(AuthenticationError.unknown))
                    }
                } else if let user = result?.user {
                    debugPrint("yello")
                    promise(.success(User(id: user.uid, email: user.email ?? "")))
                } else {
                    promise(.failure(AuthenticationError.unknown))
                }
            }
        }
        .eraseToAnyPublisher()
    }

    func register(_ credentials: Credentials) -> AnyPublisher<User, RegistrationError> {
        return Future<User, RegistrationError> { promise in
            Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { result, error in
                if let error = error as? NSError {
                    switch error.code {
                    case AuthErrorCode.emailAlreadyInUse.rawValue:
                        promise(.failure(.accountWithEmailExists))
                    case AuthErrorCode.invalidEmail.rawValue:
                        promise(.failure(.invalidEmail))
                    default:
                        promise(.failure(.unknown))
                    }
                } else if let user = result?.user {
                    promise(.success(User(id: user.uid, email: user.email ?? "")))
                } else {
                    promise(.failure(RegistrationError.unknown))
                }
            }
        }
        .eraseToAnyPublisher()
    }

}
