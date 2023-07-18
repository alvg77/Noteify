//
//  NoteCreationViewModel.swift
//  StamSoftProizvodstvena
//
//  Created by Aleko Georgiev on 13.07.23.
//

import Foundation

class NewNoteViewModel: ObservableObject {
    @Published var noteManager: NotesManager
    @Published var note = Note(id: "", title: "", body: "")
    
    @Published var hasDueDate = false {
        willSet {
            if newValue == false {
                note.due = nil
            }
        }
    }
    
    @Published var due = Date() {
        willSet {
            note.due = newValue
        }
    }
    
    var isValid: Bool {
        !note.title.isEmpty && ((hasDueDate && note.due != nil && Date() < note.due!) || (!hasDueDate && note.due == nil))
    }
    
    init(noteManager: NotesManager) {
        self.noteManager = noteManager
    }
    
    func addNote(currentUser: User?) {
        noteManager.addNote(currentUser: currentUser, note: note)
        refreshNote()
    }
    
    func refreshNote() {
        note.title = ""
        note.body = ""
        note.due = Date()
    }
}
