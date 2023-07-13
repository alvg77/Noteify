//
//  ContentView.swift
//  StamSoftProizvodstvena
//
//  Created by Aleko Georgiev on 13.07.23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var userManager = UserManager(authenticator: FakeAuthenticator())
    
    var body: some View {
        if !userManager.loggedIn {
            LoginView(loginVM: LoginViewModel(userManager: userManager))
        } else {
            NoteListView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
