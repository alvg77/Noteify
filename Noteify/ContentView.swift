//
//  ContentView.swift
//  StamSoftProizvodstvena
//
//  Created by Aleko Georgiev on 13.07.23.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @StateObject private var userManager = UsersManager(authenticator: FirebaseAuthenticator())
    @State private var navigationPath: NavigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            if !userManager.loggedIn {
                    AuthView(userManager: userManager, navigationPath: $navigationPath)
                        .navigationDestination(for: String.self, destination: { destination in
                            switch destination {
                            case "login":
                                LoginView(navigationPath: $navigationPath, loginVM: LoginViewModel(usersManager: userManager))
                            case "register":
                                RegisterView(navigationPath: $navigationPath, registerVM: RegisterViewModel(usersManager: userManager))
                            default:
                                EmptyView()
                            }
                        })
                        .onAppear {
                            Auth.auth().addStateDidChangeListener { auth, user in
                                if let user {
                                    userManager.currentUser = User(id: user.uid, email: user.email ?? "")
                                }
                            }
                        }
            } else {
                let notesManager = NotesManager()
                NoteListView(navigationPath: $navigationPath, noteVM: NoteListViewModel(noteManager: notesManager), notesManager: notesManager)
                    .environmentObject(userManager)
                    
            }
        }
        .tint(.accentColor)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
