//
//  LoginModel.swift
//  StamSoftProizvodstvena
//
//  Created by Aleko Georgiev on 12.07.23.
//

import Foundation

class UserManager: ObservableObject {
    @Published var currentUser: User?
    
    var authenticator: Authenticator
    
    var loggedIn: Bool {
        currentUser != nil
    }
    
    init(authenticator: Authenticator) {
        self.authenticator = authenticator
    }
    
    func login(_ credentials: Credentials, progress: inout ProgressStatus, error: inout AuthenticationError?) {
        let progressWrapper = Wrapper(progress)
        let errorWrapper = Wrapper(error)
        
        progressWrapper.value = .inProgress
        var _ = authenticator
            .login(Credentials(email: credentials.email, password: credentials.password))
            .subscribe(on: DispatchQueue.main)
            .sink { [weak progressWrapper, weak errorWrapper] authError in
                switch authError {
                case .finished:
                    progressWrapper?.value = .idle
                case .failure(let err):
                    errorWrapper?.value = err
                    progressWrapper?.value = .idle
                }
            } receiveValue: { [weak self] user in
                self?.currentUser = user
            }
    }
    
}
