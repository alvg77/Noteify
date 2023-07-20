//
//  NotesListView.swift
//  StamSoftProizvodstvena
//
//  Created by Aleko Georgiev on 10.07.23.
//

import SwiftUI
import Firebase

struct NoteListView: View {
    @EnvironmentObject var userManager: UsersManager
    
    @Binding var navigationPath: NavigationPath
    @StateObject var noteVM: NoteListViewModel
    @StateObject var notesManager: NotesManager
    @State private var creating = false
    @State private var detailsNote: Note?

    
    var body: some View {
        ZStack {
            Color("color.background")
                .ignoresSafeArea()
            VStack {
                heading
                    .padding([.top, .leading])
                    .frame(height: 64)
                if noteVM.notes.isEmpty {
                    noNotes
                } else {
                    notes
                }
     
                Spacer()
                plusButton
            }
        }
        .fontDesign(.rounded)
        .sheet(isPresented: $creating) {
            NewNoteView(noteVM: NewNoteViewModel(noteManager: notesManager))
                .interactiveDismissDisabled(true)
        }
        .sheet(item: $detailsNote) { detailsNote in
            DetailsNoteView(noteVM: DetailsNoteViewModel(notesManager: notesManager, note: detailsNote))
        }
        
        .onAppear {
            noteVM.fetchNotes(currentUser: userManager.currentUser)
        }
    }
 
    @ViewBuilder var heading: some View {
        HStack {
            Text("Your Notes")
                .fontWeight(.heavy)
                .font(.largeTitle)
                .bold()
                .foregroundColor(.accentColor)
            Spacer()
            Button("Logout") {
                try? Auth.auth().signOut()
                userManager.currentUser = nil
            }
        }
        .padding(.all)
    }
    
    @ViewBuilder var noNotes: some View {
        VStack {
            Spacer()
            Text("Wow, such emptiness")
                .font(.title)
            Text(#"(☞ﾟヮﾟ)☞"#)
                .padding(.top, 80)
                .font(.system(size: 56))
                .rotationEffect(Angle.degrees(50))
            Spacer()
        }
        .fontWeight(.heavy)
        .foregroundColor(.accentColor)
        .opacity(0.66)
    }
    
    @ViewBuilder var notes: some View {
        List {
            ForEach(noteVM.notes) { note in
                ZStack {
                    NoteCard(note: note) {
                        self.noteVM.updateCompletion(id: note.id)
                    }
                    
                    HStack {
                        Spacer()
                        infoButton(note: note)
                    }
                }
            }
            .onDelete { indexSet in
                for i in indexSet {
                    noteVM.deleteNote(index: i)
                }
            }
        }
    }
    
    @ViewBuilder func infoButton(note: Note) -> some View {
        Button {
            detailsNote = note
        } label: {
            Image(systemName: "info.circle.fill")
                .font(.title2)
        }
        .disabled(note.isCompleted)
        .buttonStyle(BorderlessButtonStyle())
    }
    
    @ViewBuilder var plusButton: some View {
        Button {
            creating.toggle()
        } label: {
            HStack {
                ZStack {
                    Circle()
                        .foregroundColor(.accentColor)
                        .frame(width: 32)
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                        .font(.title3)
                }
                Text("Add a note")
                    .font(.title3)
                    .fontWeight(.heavy)
            }

        }
        .padding(.all)
        .foregroundColor(.accentColor)
    }
}
