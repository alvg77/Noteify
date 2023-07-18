//
//  ContentView.swift
//  StamSoftProizvodstvena
//
//  Created by Aleko Georgiev on 6.07.23.
//

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
<<<<<<< Updated upstream:Noteify/Views/LoginView.swift
    @StateObject var loginVM = LoginViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                background
                VStack {
                    Text("Noteify")
                        .bold()
                        .padding(.top)
                        .foregroundColor(.white)
                        .font(.largeTitle)
                    Spacer()
                    loginTitle
                    loginInputFields
                    forgottenPasswordButton
                        .padding(.bottom, 40)
                    loginButton
                    Spacer()
                }
                .onSubmit {
                    if focused == .email {
                        focused = .password
                    } else {
                        focused = nil
                    }
=======
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
>>>>>>> Stashed changes:Noteify/Views/Authentication/LoginView.swift
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
    
<<<<<<< Updated upstream:Noteify/Views/LoginView.swift
    @ViewBuilder var loginTitle: some View {
        LinearGradient(
            colors: [.yellow, .purple],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .mask {
            Text("Welcome back!")
                .font(.title)
                .bold()
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.leading)
        }
        .frame(maxHeight: 25)
        .padding(.bottom)
    }
    
    @ViewBuilder var background: some View {
        LinearGradient(
            colors: [.purple, .yellow],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()

        Circle()
            .scale(1.5)
            .foregroundColor(.white.opacity(0.15))
        Circle()
            .scale(1.3)
            .foregroundColor(.white)
            .shadow(radius: 12)

=======
    @ViewBuilder private var loginTitle: some View {
        Text("Welcome back!")
            .font(.largeTitle)
            .bold()
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.leading)
            .foregroundColor(Color("color.theme"))
    }
    
    @ViewBuilder private var header: some View {
        VStack {
            Text("Login")
                .font(.system(size: 54, weight: .heavy))
                .foregroundColor(Color("color.theme"))
        }
>>>>>>> Stashed changes:Noteify/Views/Authentication/LoginView.swift
    }
    
    @ViewBuilder private var loginButton: some View {
        let inactive = !loginVM.validInput || loginVM.authProgress.inProgress
        ZStack {
            VStack {
                Button {
<<<<<<< Updated upstream:Noteify/Views/LoginView.swift
//                    loginVM.login()
=======
                    loginVM.login {
                        navigationPath = NavigationPath()
                    }
>>>>>>> Stashed changes:Noteify/Views/Authentication/LoginView.swift
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
<<<<<<< Updated upstream:Noteify/Views/LoginView.swift
                .disabled(!loginVM.validInput || loginVM.authStatus == .inProgress)
                                    
                NavigationLink("Dont have an account? Register!") {
                    RegisterView()
                }
                .padding(.bottom)
                
            }
            .opacity(loginVM.authStatus == .inProgress ? 0.2 : 1)
            
=======
                .foregroundColor(Color("color.theme"))
                .opacity(inactive ? 0.4 : 1)
                .disabled(inactive)
                
            }
            .opacity(loginVM.authProgress.inProgress ? 0.2 : 1)

>>>>>>> Stashed changes:Noteify/Views/Authentication/LoginView.swift
            ProgressView()
                .opacity(loginVM.authStatus == .inProgress ? 1 : 0)
        }
    }
    
    @ViewBuilder private var register: some View {
        Button("Don't have an account? Register today!") {
            navigationPath.append("register")
        }
        .foregroundColor(Color("color.theme"))
    }
    
    @ViewBuilder private var errorMessage: some View {
        HStack {
            if !loginVM.errorMessage.isEmpty { Image(systemName: "exclamationmark.triangle")
            }
<<<<<<< Updated upstream:Noteify/Views/LoginView.swift
            .font(.footnote)
            .bold()
            .padding(.trailing)
=======
            Text("\(loginVM.errorMessage)")
                .bold()
                .font(.callout)
                .animation(.default, value: loginVM.errorMessage)
>>>>>>> Stashed changes:Noteify/Views/Authentication/LoginView.swift
        }
        .foregroundColor(.red)
    }
    
<<<<<<< Updated upstream:Noteify/Views/LoginView.swift
    @ViewBuilder var loginInputFields: some View {
        VStack (spacing: 15) {
            Text("")
                .bold()
                .foregroundColor(.red)
                .font(.callout)
            HStack {
                TextField("Email", text: $loginVM.credentials.email)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)

                Image(systemName: "envelope")
            }
            .borderedBackground(lineWidth: focused == .email ? 2 : 1, shadowRadius: focused == .email ? 4 : 0)
            .padding(.horizontal)
            .focused($focused, equals: .email)
            .animation(.default, value: focused)

            PasswordField(password: $loginVM.credentials.password)
            .focused($focused, equals: .password)
        }
    }

}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(loginVM: LoginViewModel())
    }
=======
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
>>>>>>> Stashed changes:Noteify/Views/Authentication/LoginView.swift
}
