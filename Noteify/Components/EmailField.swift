//
//  EmailField.swift
//  StamSoftProizvodstvena
//
//  Created by Aleko Georgiev on 13.07.23.
//

import SwiftUI

struct EmailField: View {
    @Binding var email: String
    @FocusState var focused: Bool
    
    var body: some View {
        HStack {
            Image(systemName: "at")
                .foregroundColor(.primary)
                .padding(.leading)

            TextField("Email", text: $email)
                .textContentType(.emailAddress)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
                .focused($focused)
        }
    }
}
