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
    
    let title: String
    @Binding var password: String
    @FocusState var focused: TextFieldFocus?
    @State var isShown = false
    
    var body: some View {
        HStack {
            Image(systemName: "lock")
                .foregroundColor(.primary)
            ZStack {
                TextField(title, text: $password)
                    .opacity(isShown ? 1 : 0)
                    .focused($focused, equals: .shown)
                
                SecureField(title, text: $password)
                    .opacity(isShown ? 0 : 1)
                    .focused($focused, equals: .hidden)
            }
            Button {
                isShown.toggle()
            } label: {
                Image(systemName: isShown ? "eye" : "eye.slash")
                    .animation(.default)
                    .foregroundColor(.primary)
            }
        }
        .padding(.horizontal)

    }
}
