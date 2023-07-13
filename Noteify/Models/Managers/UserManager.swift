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
    var authPublusher: AnyCancellable?
    
    var loggedIn: Bool {
        currentUser != nil
    }
    
    init(authenticator: Authenticator) {
        self.authenticator = authenticator
    }
    
    func login(credentials: Credentials, onCompletion: @escaping (Subscribers.Completion<AuthenticationError>) -> Void) {
        
        authPublusher = authenticator
            .login(credentials)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                onCompletion(completion)
            } receiveValue: { [weak self] user in
                self?.currentUser = user
            }
    }
    
}
