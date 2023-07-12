//
//  HStackBorderStyle.swift
//  StamSoftProizvodstvena
//
//  Created by Aleko Georgiev on 7.07.23.
//

import SwiftUI

struct BorderStyle: LabelStyle {
    var cornerRadius: CGFloat
    var focused: Bool
    var color: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .padding(.all)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(lineWidth: focused ? 2 : 1)
                    .shadow(radius: focused ? 4 : 0)
            )
            .foregroundColor(color)
    }
}
