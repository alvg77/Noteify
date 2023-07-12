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
            Image(systemName: "lock")
                .foregroundColor(.black)
            
            ZStack {
                TextField("Password", text: $password)
                    .foregroundColor(.black)
                    .opacity(isShown ? 1 : 0)
                    .focused($focused, equals: .shown)
                
                SecureField("Password", text: $password)
                    .foregroundColor(.black)
                    .opacity(isShown ? 0 : 1)
                    .focused($focused, equals: .hidden)
            }

            Button {
                isShown.toggle()
            } label: {
                Image(systemName: isShown ? "eye" : "eye.slash")
                    .animation(.default)
                    .foregroundColor(.black)

            }
        }
//        .borderedBackground(lineWidth: focused == .hidden ? 2 : 1, shadowRadius: focused == .hidden ? 4 : 0)

        .padding(.horizontal)
        .padding(.bottom, 8)
    }
    
        
}
