//
//  NoteCreationViewModel.swift
//  StamSoftProizvodstvena
//
//  Created by Aleko Georgiev on 13.07.23.
//

import Foundation

class NewNoteViewModel: ObservableObject {
    @Published var noteManager: NotesManager
    @Published var note = Note(id: "", title: "", body: "", due: Date())
    
    var isValid: Bool {
        !note.title.isEmpty && Date() < note.due
    }
    
    init(noteManager: NotesManager) {
        self.noteManager = noteManager
    }
    
    func addNote(currentUser: User?) {
        debugPrint(note.due)
        noteManager.addNote(currentUser: currentUser, note: note)
        refreshNote()
    }
    
    func refreshNote() {
        note.title = ""
        note.body = ""
        note.due = Date()
    }
}
