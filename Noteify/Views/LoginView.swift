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
    @ObservedObject var loginVM: LoginViewModel
    
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
        Text("Welcome back!")
            .font(.largeTitle)
            .bold()
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.leading)
            .foregroundColor(.cyan)
    }
    
    @ViewBuilder var background: some View {
        ThemeGradient()
            .ignoresSafeArea()

        Circle()
            .scale(1.5)
            .foregroundColor(.white.opacity(0.15))
        
        Circle()
            .scale(1.3)
            .shadow(radius: 12)
            .foregroundColor(.white)
    }
    
    @ViewBuilder var loginButton: some View {
        ZStack {
            VStack {
                Button {
                    loginVM.login()
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
<<<<<<< HEAD
                .disabled(!loginVM.validInput || loginVM.authInProgress)
=======
                .disabled(!loginVM.validInput || loginVM.authStatus == .inProgress)
>>>>>>> origin/dev
                                    
                NavigationLink("Dont have an account? Register!") {
                    RegisterView()
                }
                .foregroundColor(.cyan)
                .padding(.bottom)
                
            }
<<<<<<< HEAD
            .opacity(loginVM.authInProgress ? 0.2 : 1)
            
            ProgressView()
                .opacity(loginVM.authInProgress ? 1 : 0)
=======
            .opacity(loginVM.authStatus == .inProgress ? 0.2 : 1)
            
            ProgressView()
                .opacity(loginVM.authStatus == .inProgress ? 1 : 0)
>>>>>>> origin/dev
        }
    }
    
    @ViewBuilder var forgottenPasswordButton: some View {
        HStack {
            Spacer()
            NavigationLink("Forgotten password") {
                ForgottenPassword()
            }
            .foregroundColor(.cyan)
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
<<<<<<< HEAD
                Image(systemName: "at")
                    .foregroundColor(.black)
                
=======
>>>>>>> origin/dev
                TextField("Email", text: $loginVM.credentials.email)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)

            }
            .padding(.horizontal)
            .padding(.bottom, 8)
            .animation(.default, value: focused)
<<<<<<< HEAD
            .overlay(
                Rectangle()
                    .foregroundColor(.cyan)
                    .padding(.horizontal)
                    .frame(width: nil, height: 2),
                alignment: .bottom
            )
        
            PasswordField(password: $loginVM.credentials.password)
            .overlay(
                Rectangle()
                    .foregroundColor(.cyan)
                    .padding(.horizontal)
                    .frame(width: nil, height: 2),
                alignment: .bottom
                
            )
=======

            PasswordField(password: $loginVM.credentials.password)
            .focused($focused, equals: .password)
>>>>>>> origin/dev
        }
    }
}
