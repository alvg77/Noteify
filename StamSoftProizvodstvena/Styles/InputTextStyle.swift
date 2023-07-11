//
//  InputTextStlye.swift
//  StamSoftProizvodstvena
//
//  Created by Aleko Georgiev on 7.07.23.
//

import SwiftUI

struct InputTextStyle: TextFieldStyle {
    var keyboardType: UIKeyboardType
    var FSSymbolName: String = ""
    
    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .padding(.all)
            .keyboardType(keyboardType)
            .autocapitalization(.none)
    }
}
