//
//  LoginViewModel.swift
//  StamSoftProizvodstvena
//
//  Created by Aleko Georgiev on 6.07.23.
//

import Foundation
import Combine

struct Credentials {
    var email: String
    var password: String
}

struct User: Sendable {
    var email: String
    var password: String
}

//protocol Authenticator  {
//    func login(_ credentials: Credentials) async throws -> User
//}

class FakeAuthenticator {
//    func login(_ credentials: Credentials) async throws -> User {
//        if credentials.email == "a@a.a" {
//            if credentials.password == "Test123!" {
//                return User(email: credentials.email, password: credentials.password)
//            } else {
//                throw WrongCredentialsError.passwordDoesNotMatch
//            }
//        } else {
//            throw WrongCredentialsError.emailDoesNotExist
//        }
//    }
    
    func login(_ credentials: Credentials) -> AnyPublisher<User, WrongCredentialsError> {
        guard credentials.email == "a@a.a" && credentials.password == "pass" else {
            return Fail(error: WrongCredentialsError.wrongPasswordOrEmail)
                .eraseToAnyPublisher()
        }
        
        return Just<Credentials>(credentials)
            .setFailureType(to: WrongCredentialsError.self)
            .filter { credentials in
                credentials.email == "a@a.a" && credentials.password == "pass"
            }
            .map { credentials in
                User(email: credentials.email, password: credentials.password)
            }
            .delay(for: 2, scheduler: DispatchQueue.global())
            .eraseToAnyPublisher()
    }
    
}

enum WrongCredentialsError: Error {
    case wrongPasswordOrEmail
}

class LoginViewModel: ObservableObject {
    private static let emailRegex = #/(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])/#
    
    @Published var loginModel = LoginModel()
    @Published var email = ""
    @Published var password = ""
    
    var isLoggedIn: Bool {
        currentUser != nil
    }
    
    @Published var errorMessage: String = ""
    @Published var authFetchStatus = LoginCredentialsAuthStatus.idle
    
    private var currentUser: User?
    private var auth = FakeAuthenticator()
    
    var validInput: Bool {
        validateEmail() && validatePassword()
    }
    
    func validateEmail() -> Bool {
        return email.wholeMatch(of: LoginViewModel.emailRegex) != nil
    }
    
    func validatePassword() -> Bool {
        return !password.isEmpty
    }
    
    func login() {
        authFetchStatus = .authenticating
        auth.login(Credentials(email: email, password: password))
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink { fail in
                print(fail)
            } receiveValue: { [weak self] user in
                self?.currentUser = user
                self?.authFetchStatus = .idle
            }
        
        
//        authFetchStatus = .authenticating
//        Task {
//            try await Task.sleep(nanoseconds: 3_000_000_000)
//            do {
//                let user = try await self.auth.login(Credentials(email: self.email, password: self.password))
//
//                DispatchQueue.main.async { [weak self] in
//                    self?.currentUser = user
//                    self?.authFetchStatus = .idle
//                }
//            } catch WrongCredentialsError.emailDoesNotExist {
//                DispatchQueue.main.async { [weak self] in
//                    self?.errorMessage = "Email does not exist!"
//                    self?.authFetchStatus = .idle
//                }
//            } catch WrongCredentialsError.passwordDoesNotMatch {
//                DispatchQueue.main.async { [weak self] in
//                    self?.errorMessage = "Password does not match!"
//                    self?.authFetchStatus = .idle
//                }
//            }
//        }
    }
    
    enum LoginCredentialsAuthStatus {
        case idle
        case authenticating
    }
}
