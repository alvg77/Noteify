//
//  PasswordField.swift
//  StamSoftProizvodstvena
//
//  Created by Aleko Georgiev on 7.07.23.
//

import SwiftUI

struct PasswordField: View {
    
    enum TextFieldFocus {
        case hidden
        case shown
    }
    
    @Binding var password: String
    @FocusState var focused: TextFieldFocus?
    @State var isShown = false
    
    var body: some View {
        HStack {
            ZStack {
                TextField("Password", text: $password)
                    .opacity(isShown ? 1 : 0)
                    .focused($focused, equals: .shown)
                
                SecureField("Password", text: $password)
                    .opacity(isShown ? 0 : 1)
                    .focused($focused, equals: .hidden)
            }
            Button {
                isShown.toggle()
            } label: {
                Image(systemName: isShown ? "eye" : "eye.slash")
                    .animation(.default)

            }
        }
        .borderedBackground(lineWidth: focused == .hidden ? 2 : 1, shadowRadius: focused == .hidden ? 4 : 0)

        .padding([.leading, .bottom, .trailing])
    }
    
        
}
