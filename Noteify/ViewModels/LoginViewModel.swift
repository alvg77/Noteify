import Foundation
import Combine

class LoginViewModel: ObservableObject {
    private static let emailRegex = #/(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])/#
    
    @Published var userManager: UserManager
    @Published var credentials = Credentials(email: "", password: "")
    @Published var authProgress: ProgressStatus = .idle

    private var error: AuthenticationError? {
        willSet {
            errorMessage = newValue?.errorDescription ?? ""
        }
    }
    
    init(userManager: UserManager) {
        self.userManager = userManager
        self.credentials = credentials
    }

    
    @Published var errorMessage: String = ""
    
    func login(){
        authProgress = .inProgress
        userManager.login(credentials: credentials) { [weak self] completion in
            switch completion {
            case .finished:
                self?.authProgress = .idle
            case .failure(let error):
                self?.error = error
                self?.authProgress = .idle
            }
        }
            
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

}
