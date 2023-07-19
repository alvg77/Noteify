//
//  SwiftUIView.swift
//  StamSoftProizvodstvena
//
//  Created by Aleko Georgiev on 6.07.23.
//

import SwiftUI

struct RegisterView: View {
    enum FocusedField {
        case email
        case password
        case repeatPassword
    }
    
    @Binding var navigationPath: NavigationPath
    
    @State private var isShown = false
    @State private var navigationSelection = false
    @State private var helpSelection = false
    @FocusState private var focused: FocusedField?
    @StateObject var registerVM: RegisterViewModel
    
    var body: some View {
        ZStack {
            Color("color.background")
                .ignoresSafeArea()
            VStack {
                header
                .padding(.bottom, 64)
                
                registerInputFields
                errorMessage
                    .padding(.all)
                
                registerButton
                login
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
    
    @ViewBuilder var loginTitle: some View {
        Text("Welcome back!")
            .font(.largeTitle)
            .bold()
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.leading)
            .foregroundColor(.accentColor)
    }
    
    @ViewBuilder var header: some View {
        VStack {
            Text("Register")
                .font(.system(size: 54, weight: .heavy))
                .fontWeight(.heavy)
                .foregroundColor(.accentColor)
        }
    }
    
    @ViewBuilder var registerButton: some View {
        let inactive = !registerVM.isValid || registerVM.authStatus.inProgress
        ZStack {
            VStack {
                Button {
                    registerVM.register() {
                        navigationPath = NavigationPath()
                    }
                } label: {
                    ZStack {
                        Text("Register")
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
            .opacity(registerVM.authStatus.inProgress ? 0.2 : 1)
            
            ProgressView()
                .opacity(registerVM.authStatus.inProgress ? 1 : 0)
        }
    }
    
    @ViewBuilder var errorMessage: some View {
        HStack {
            if registerVM.error != nil {
                Image(systemName: "exclamationmark.triangle")
            }
            Text("\(registerVM.errorMessage)")
                .bold()
                .font(.callout)
                .animation(.default, value: registerVM.errorMessage)
        }
        .foregroundColor(.red)
    }
    
    @ViewBuilder var login: some View {
        Button("Already have an account? Tap here to login!") {
            navigationPath.append("login")
        }
        .foregroundColor(.accentColor)
    }

    
    @ViewBuilder var registerInputFields: some View {
        VStack (spacing: 15) {
            Group {
                EmailField(email: $registerVM.credentials.email)
                    .focused($focused, equals: .email)
                PasswordField(title: "Password", password: $registerVM.credentials.password)
                    .focused($focused, equals: .password)
                PasswordField(title: "Repeat password", password: $registerVM.confirmPassword)
                    .focused($focused, equals: .repeatPassword)
            }
                .padding(.all)
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .padding(.horizontal)
                        .foregroundColor(Color("color.element"))
                    
                )
                .animation(.default, value: focused)
            
            Button {
                withAnimation {
                    helpSelection.toggle()
                }
            } label: {
                Image(systemName: "questionmark.circle")
            }
            
            if helpSelection && focused == .none {
                Text("Passwords should include:\n- at least 6 characters\n- at least one english letter\n- at least one number\n- at least one special character")
                    .lineLimit(5, reservesSpace: true)
                    .foregroundColor(.accentColor)
                    .padding(.all)
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                            .foregroundColor(Color("color.element"))
                    )
                    .font(.footnote)
            }            
        }
    }
}
