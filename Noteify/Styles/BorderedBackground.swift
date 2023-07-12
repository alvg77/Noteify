//
//  TextFieldBackGround.swift
//  StamSoftProizvodstvena
//
//  Created by Aleko Georgiev on 7.07.23.
//

import SwiftUI

struct BorderedBackground: ViewModifier {
    var cornerRadius: CGFloat
    var lineWidth: CGFloat
    var shadowRadius: CGFloat
    var color: Color
    
    
    @ViewBuilder
    func body(content: Content) -> some View {
        content
            .padding(.all)
            .background(
                RoundedRectangle(
                    cornerRadius: cornerRadius
                )
                .stroke(lineWidth: lineWidth)
                .shadow(radius: shadowRadius)
            )
            .foregroundColor(color)
    }
}

extension View {
    func borderedBackground(lineWidth: CGFloat, shadowRadius: CGFloat, cornerRadius: CGFloat = 12, color: Color = .accentColor) -> some View{
        modifier(BorderedBackground(cornerRadius: cornerRadius, lineWidth: lineWidth, shadowRadius: shadowRadius, color: color))
    }
}
