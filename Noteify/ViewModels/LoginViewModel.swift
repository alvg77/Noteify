//
//  LoginViewModel.swift
//  StamSoftProizvodstvena
//
//  Created by Aleko Georgiev on 6.07.23.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    private static let emailRegex = #/(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])/#
    
<<<<<<< HEAD
    @Published var userManager: UserManager
    @Published var credentials = Credentials(email: "", password: "")
=======
    @Published var loginModel = LoginModel()
    @Published var credentials = Credentials(email: "", password: "")
    @Published var error: String = ""
    @Published var authStatus = ProgressStatus.idle
>>>>>>> origin/dev
    
    
    init(userManager: UserManager, credentials: Credentials = Credentials(email: "", password: "")) {
        self.userManager = userManager
        self.credentials = credentials
    }
    
    var errorMessage: String {
        userManager.error?.errorDescription ?? ""
    }
    
    func login(){
        userManager.login(credentials)
    }
    
    var authInProgress: Bool {
        userManager.authProgress == .inProgress
    }
    
    var validInput: Bool {
        validateEmail() && validatePassword()
    }
    
    func validateEmail() -> Bool {
        return credentials.email.wholeMatch(of: LoginViewModel.emailRegex) != nil
    }
    
    func validatePassword() -> Bool {
        return !credentials.password.isEmpty
    }
<<<<<<< HEAD
=======
    
    func login(){
        authStatus = .inProgress
        var _ = auth.login(Credentials(email: credentials.email, password: credentials.password))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] authError in
                switch authError {
                case .finished:
                    debugPrint("successfully finished")
                    self?.authStatus = .idle
                case .failure(let err):
                    self?.error = err.errorDescription
                    self?.authStatus = .idle
                }
            } receiveValue: { [weak self] user in
                self?.loginModel.login(user)
            }
    }

>>>>>>> origin/dev
}
