import SwiftUI
import Combine


struct LoginView: View {
    enum FocusedField {
        case email
        case password
    }
    
    @Binding var navigationPath: NavigationPath
    
    @State private var isShown = false
    @State private var navigationSelection: Bool = false
    @FocusState private var focused: FocusedField?
    @StateObject var loginVM: LoginViewModel
        
    var body: some View {
        ZStack {
            Color("color.background")
                .ignoresSafeArea()
            VStack {
                header
                .padding(.bottom, 64)
                
                loginInputFields
                errorMessage
                    .padding(.all)
                
                loginButton
                register
            }
            .onSubmit {
                if focused == .email {
                    focused = .password
                } else {
                    focused = nil
                }
            }
        }
        .bold()
        .fontDesign(.rounded)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") {
                    focused = .none
                }
            }
        }
        .ignoresSafeArea(.keyboard)

    }

    @ViewBuilder private var loginTitle: some View {
        Text("Welcome back!")
            .font(.largeTitle)
            .bold()
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.leading)
            .foregroundColor(.accentColor)
    }
    
    @ViewBuilder private var header: some View {
        VStack {
            Text("Login")
                .font(.system(size: 54, weight: .heavy))
                .foregroundColor(.accentColor)
        }
    }
    
    @ViewBuilder private var loginButton: some View {
        let inactive = !loginVM.validInput || loginVM.authStatus.inProgress
        ZStack {
            VStack {
                Button {
                    loginVM.login() {
                        navigationPath = NavigationPath()
                    }
                } label: {
                    ZStack {
                        Text("Login")
                            .foregroundColor(.white)
                            .padding(.all)
                            .frame(maxWidth: 170)
                            .background(
                                RoundedRectangle(cornerRadius: .infinity)
                                    .shadow(radius: inactive ? 0 : 2 , y: inactive ? 0 : 4)
                            )
                            .padding(.all)
                    }
                }
                .padding([.trailing, .leading])
                .foregroundColor(.accentColor)
                .opacity(inactive ? 0.4 : 1)
                .disabled(inactive)
                
            }
            .opacity(loginVM.authStatus.inProgress ? 0.2 : 1)

            ProgressView()
                .opacity(loginVM.authStatus.inProgress ? 1 : 0)
        }
    }
    
    @ViewBuilder private var register: some View {
        Button("Don't have an account? Register today!") {
            navigationPath.append("register")
        }
        .foregroundColor(.accentColor)
    }
    
    @ViewBuilder private var errorMessage: some View {
        HStack {
            if loginVM.error != nil {
                Image(systemName: "exclamationmark.triangle")
            }
            Text("\(loginVM.errorMessage)")
                .bold()
                .font(.callout)
                .animation(.default, value: loginVM.errorMessage)
        }
        .foregroundColor(.red)
    }
    
    @ViewBuilder private var loginInputFields: some View {
        VStack (spacing: 15) {
            Group {
                EmailField(email: $loginVM.credentials.email)
                    .focused($focused, equals: .email)
                PasswordField(title: "Password", password: $loginVM.credentials.password)
                    .focused($focused, equals: .password)
            }
                .padding(.all)
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .padding(.horizontal)
                        .foregroundColor(Color("color.element"))
                )
                .animation(.default, value: focused)
        }
    }
}
