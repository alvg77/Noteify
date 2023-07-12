//
//  ContentView.swift
//  StamSoftProizvodstvena
//
//  Created by Aleko Georgiev on 12.07.23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var userManager: UserManager
    
    var body: some View {
            if !userManager.loggedIn {
                LoginView(loginVM: LoginViewModel(userManager: userManager))
            } else {
                NoteListView(noteVM: NoteViewModel())
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(userManager: UserManager(authenticator: FakeAuthenticator()))
    }
}
