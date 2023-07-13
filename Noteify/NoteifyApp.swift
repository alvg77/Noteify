//
//  StamSoftProizvodstvenaApp.swift
//  StamSoftProizvodstvena
//
//  Created by Aleko Georgiev on 6.07.23.
//

import SwiftUI

@main
struct NoteifyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(userManager: UserManager(authenticator: FakeAuthenticator()))
        }
    }
}
