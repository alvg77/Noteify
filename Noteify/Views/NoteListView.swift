//
//  NotesListView.swift
//  StamSoftProizvodstvena
//
//  Created by Aleko Georgiev on 10.07.23.
//

import SwiftUI

struct NoteListView: View {
    @EnvironmentObject var userManager: UsersManager
    
    @Binding var navigationPath: NavigationPath
    @StateObject var noteVM: NoteListViewModel
    @StateObject var notesManager: NotesManager
    @State private var creating =  false
    
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
                .foregroundColor(Color("color.theme"))
            Spacer()
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
        .foregroundColor(Color("color.theme"))
        .opacity(0.66)
    }
    
    @ViewBuilder var notes: some View {
        List {
            ForEach(noteVM.notes) { note in
                NoteCard(note: note) {
                    self.noteVM.updateCompletion(id: note.id)
                }
            }
            .onDelete { indexSet in
                for i in indexSet {
                    noteVM.deleteNote(index: i)
                }
            }
        }
    }
    
    @ViewBuilder var plusButton: some View {
        Button {
            creating.toggle()
        } label: {
            HStack {
                ZStack {
                    Circle()
                        .foregroundColor(Color("color.theme"))
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
        .foregroundColor(Color("color.theme"))
    }
}
