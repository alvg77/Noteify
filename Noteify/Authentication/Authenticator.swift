//
//  Authenticator.swift
//  StamSoftProizvodstvena
//
//  Created by Aleko Georgiev on 11.07.23.
//

import Foundation
import Combine

protocol Authenticator {
    typealias User = LoginModel.User
    func login(_ credentials: Credentials) -> AnyPublisher<User, AuthenticationError>
//    func register(_ credentials: Credentials) async throws -> AnyPublisher<User, any Error>
}
