//
//  LoginModel.swift
//  StamSoftProizvodstvena
//
//  Created by Aleko Georgiev on 12.07.23.
//

import Foundation
import Combine

class UserManager: ObservableObject {
    @Published var currentUser: User?
    
    var authenticator: Authenticator
    private var completionPublisher: AnyPublisher<Subscribers.Completion<AuthenticationError>, Never>?
    private var authCancellable: AnyCancellable?
    
    var loggedIn: Bool {
        currentUser != nil
    }
    
    init(authenticator: Authenticator) {
        self.authenticator = authenticator
    }
    
    func login(_ credentials: Credentials) -> AnyPublisher<Subscribers.Completion<AuthenticationError>, Never>? {
        Future<Subscribers.Completion<AuthenticationError>, Never> { [weak self] promise in
            self?.authCancellable = self?.authenticator
                .login(credentials)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    promise(.success(completion))
                }, receiveValue: { [weak self] user in
                    self?.currentUser = user
                })
        }
        .eraseToAnyPublisher()
    }
}
