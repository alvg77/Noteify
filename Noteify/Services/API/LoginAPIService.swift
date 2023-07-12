//
//  LoginAPIService.swift
//  StamSoftProizvodstvena
//
//  Created by Aleko Georgiev on 11.07.23.
//

import Foundation

class LoginAPIService {
    static let shared = LoginAPIService()
    func login(credentials: Credentials, completion: @escaping (Result<Bool, WrongCredentialsError>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if credentials.password == "pass" {
                completion(.success(true))
            } else {
                completion(.failure(WrongCredentialsError.passwordDoesNotMatch))
            }
        }
    }
}
