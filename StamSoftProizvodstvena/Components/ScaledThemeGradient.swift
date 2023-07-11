//
//  ThemeGradient.swift
//  StamSoftProizvodstvena
//
//  Created by Aleko Georgiev on 7.07.23.
//

import SwiftUI

struct ScaledThemeGradient: View {
    var textData: String
    var font: Font
    
    var body: some View {
        LinearGradient(
            colors: [.cyan, .blue, .green, .mint],
            startPoint: .leading,
            endPoint: .bottom
        )
        .mask(
            Text(textData)
                .bold()
                .font(font)
        )
    }
}
