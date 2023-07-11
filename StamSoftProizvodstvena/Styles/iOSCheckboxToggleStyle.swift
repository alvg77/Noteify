//
//  iOSCheckboxToggleStyle.swift
//  StamSoftProizvodstvena
//
//  Created by Aleko Georgiev on 7.07.23.
//

import SwiftUI

struct iOSCheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            HStack {
                Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                configuration.label
            }
        }

    }
}
