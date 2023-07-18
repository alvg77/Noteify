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
    @StateObject var loginVM: LoginViewModel
    
    var body: some View {
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
                errorMessage
                    .padding(.all)
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
                .disabled(!loginVM.validInput || loginVM.authProgress.inProgress)
                
                
                NavigationLink("Dont have an account? Register!") {
                    RegisterView()
                }
                .foregroundColor(.cyan)
                .padding(.bottom)
                
            }
            .opacity(loginVM.authProgress.inProgress ? 0.2 : 1)
            
            ProgressView()
                .opacity(loginVM.authProgress.inProgress ? 1 : 0)
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
    
    @ViewBuilder var errorMessage: some View {
        Text("\(loginVM.errorMessage)")
            .bold()
            .foregroundColor(.red)
            .font(.callout)
            .animation(.default, value: loginVM.errorMessage)
    }
    
    @ViewBuilder var loginInputFields: some View {
         VStack (spacing: 15) {

             Group {
                 HStack {
                     Image(systemName: "at")
                         .foregroundColor(.black)
                     
                     TextField("Email", text: $loginVM.credentials.email)
                         .textInputAutocapitalization(.never)
                         .autocorrectionDisabled(true)

                 }
                 .animation(.default, value: focused)
             
                 PasswordField(password: $loginVM.credentials.password)
             }
             .padding([.horizontal, .bottom])
             .overlay(
                 Rectangle()
                     .foregroundColor(.cyan)
                     .padding(.horizontal)
                     .frame(width: nil, height: 2),
                 alignment: .bottom
             )
         }

     }
}
