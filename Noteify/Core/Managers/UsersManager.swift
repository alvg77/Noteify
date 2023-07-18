////
////  LoginModel.swift
////  StamSoftProizvodstvena
////
////  Created by Aleko Georgiev on 12.07.23.
////
//
//import Foundation
//import Combine
//import Firebase
//
//class UserManager: ObservableObject {
//    @Published var currentUser: User?
//
//    var authenticator: Authenticator
//    private var completionPublisher: AnyPublisher<Subscribers.Completion<AuthenticationError>, Never>?
//    private var authCancellables: Set<AnyCancellable> = []
//
//    var loggedIn: Bool {
//        currentUser != nil
//    }
//
//    init(authenticator: Authenticator) {
//        self.authenticator = authenticator
//    }
//
//    func login(_ credentials: Credentials) -> AnyPublisher<Subscribers.Completion<AuthenticationError>, Never>? {
//        Future<Subscribers.Completion<AuthenticationError>, Never> { [weak self] promise in
//            let authCancellable = self?.authenticator
//            .login(credentials)
//            .receive(on: DispatchQueue.main)
//            .sink(receiveCompletion: { completion in
//                promise(.success(completion))
//            }, receiveValue: { [weak self] user in
//                self?.currentUser = user
//            })
//
//            if authCancellable != nil {
//                self?.authCancellables.insert(
//                    authCancellable!
//                )
//            }
//        }
//        .eraseToAnyPublisher()
//    }
//
//    func register(_ credentials: Credentials) -> AnyPublisher<Subscribers.Completion<RegistrationError>, Never>? {
//        Future<Subscribers.Completion<RegistrationError>, Never> { [weak self] promise in
//            let authCancellable = self?.authenticator
//            .register(credentials)
//            .receive(on: DispatchQueue.main)
//            .sink(receiveCompletion: { completion in
//                debugPrint("compleion")
//                promise(.success(completion))
//            }, receiveValue: { [weak self] user in
//                debugPrint("registered")
//                self?.currentUser = user
//            })
//
//            if authCancellable != nil {
//                self?.authCancellables.insert(
//                    authCancellable!
//                )
//            }
//        }
//        .eraseToAnyPublisher()
//    }
//}


//
//  LoginModel.swift
//  StamSoftProizvodstvena
//
//  Created by Aleko Georgiev on 12.07.23.
//

import Foundation
import Combine
import Firebase

class UsersManager: ObservableObject {
    @Published var currentUser: User?
    
    var authenticator: Authenticator
    private var completionPublisher: AnyPublisher<Subscribers.Completion<AuthenticationError>, Never>?
    private var authCancellables: Set<AnyCancellable> = []
    
    var loggedIn: Bool {
        currentUser != nil
    }
    
    init(authenticator: Authenticator) {
        self.authenticator = authenticator
    }
    
    func login(_ credentials: Credentials) -> AnyPublisher<Subscribers.Completion<AuthenticationError>, Never> {
        Future<Subscribers.Completion<AuthenticationError>, Never> { [weak self] promise in
            let authCancellable = self?.authenticator
            .login(credentials)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                debugPrint("compleion")
                promise(.success(completion))
            }, receiveValue: { [weak self] user in
                debugPrint("registered")
                self?.currentUser = user
            })

            if authCancellable != nil {
                self?.authCancellables.insert(
                    authCancellable!
                )
            }
        }
        .eraseToAnyPublisher()
    }
    
    func register(_ credentials: Credentials) -> AnyPublisher<Subscribers.Completion<RegistrationError>, Never> {
        Future<Subscribers.Completion<RegistrationError>, Never> { [weak self] promise in
            let authCancellable = self?.authenticator
            .register(credentials)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                debugPrint("compleion")
                promise(.success(completion))
            }, receiveValue: { [weak self] user in
                debugPrint("registered")
                self?.currentUser = user
            })

            if authCancellable != nil {
                self?.authCancellables.insert(
                    authCancellable!
                )
            }
        }
        .eraseToAnyPublisher()
    }

}

