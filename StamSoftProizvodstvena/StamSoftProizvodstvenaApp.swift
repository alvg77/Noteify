//
//  StamSoftProizvodstvenaApp.swift
//  StamSoftProizvodstvena
//
//  Created by Aleko Georgiev on 6.07.23.
//

import SwiftUI

@main
struct StamSoftProizvodstvenaApp: App {
    var body: some Scene {
        WindowGroup {
            LoginView(loginVM: LoginViewModel())
        }
    }
}
