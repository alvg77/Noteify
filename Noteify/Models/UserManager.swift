//
//  LoginModel.swift
//  StamSoftProizvodstvena
//
//  Created by Aleko Georgiev on 12.07.23.
//

import Foundation

class UserManager: ObservableObject {
    @Published var error: AuthenticationError?
    @Published var authProgress: ProgressStatus
    @Published var currentUser: User?
    
    var authenticator: Authenticator
    
    var loggedIn: Bool {
        currentUser != nil
    }
    
    init(error: AuthenticationError? = nil, authProgress: ProgressStatus = ProgressStatus.idle, currentUser: User? = nil, authenticator: Authenticator) {
        self.error = error
        self.authProgress = authProgress
        self.currentUser = currentUser
        self.authenticator = authenticator
    }
    
    func login(_ credentials: Credentials) {
        authProgress = .inProgress
        var _ = authenticator
            .login(Credentials(email: credentials.email, password: credentials.password))
            .subscribe(on: DispatchQueue.main)
            .sink { [weak self] authError in
                switch authError {
                case .finished:
                    debugPrint("successfully finished")
                    self?.authProgress = .idle
                case .failure(let err):
                    debugPrint("pppoopoo")
                    self?.error = err
                    self?.authProgress = .idle
                }
            } receiveValue: { [weak self] user in
                debugPrint("pppoopoo")
                self?.currentUser = user
            }
    }
    
}
