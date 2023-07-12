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
        case button
    }
    
    @State private var isShown = false
    @State private var navigationSelection: Bool = false
    @FocusState private var focused: FocusedField?
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
                }
            }
        }
    }
    
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

    }
    
    @ViewBuilder var loginButton: some View {
        ZStack {
            VStack {
                Button {
//                    loginVM.login()
                } label: {
                    ZStack {
                        Text("Log In")
                            .foregroundColor(.white)
                            .padding(.all)
                            .frame(maxWidth: .infinity)
                            .background(RoundedRectangle(cornerRadius: .infinity))
                    }
                }
                .padding([.trailing, .leading])
                .disabled(!loginVM.validInput || loginVM.authStatus == .inProgress)
                                    
                NavigationLink("Dont have an account? Register!") {
                    RegisterView()
                }
                .padding(.bottom)
                
            }
            .opacity(loginVM.authStatus == .inProgress ? 0.2 : 1)
            
            ProgressView()
                .opacity(loginVM.authStatus == .inProgress ? 1 : 0)
        }
    }
    
    @ViewBuilder var forgottenPasswordButton: some View {
        HStack {
            Spacer()
            NavigationLink("Forgotten password") {
                ForgottenPassword()
            }
            .font(.footnote)
            .bold()
            .padding(.trailing)
        }
        .padding(.horizontal)
    }
    
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
}
