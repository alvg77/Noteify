//
//  ThemeGradient.swift
//  StamSoftProizvodstvena
//
//  Created by Aleko Georgiev on 12.07.23.
//

import SwiftUI

struct ThemeGradient: View {
    var body: some View {
        LinearGradient(
            colors: [.yellow, .purple],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}

struct ThemeGradient_Previews: PreviewProvider {
    static var previews: some View {
        ThemeGradient()
    }
}
