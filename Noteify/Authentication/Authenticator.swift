//
//  Authenticator.swift
//  StamSoftProizvodstvena
//
//  Created by Aleko Georgiev on 11.07.23.
//

import Foundation
import Combine

protocol Authenticator {

    func login(_ credentials: Credentials) -> Future<User, AuthenticationError>
//    func register(_ credentials: Credentials) async throws -> AnyPublisher<User, any Error>
}
