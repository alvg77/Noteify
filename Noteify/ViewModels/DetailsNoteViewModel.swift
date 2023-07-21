//
//  DetailsNoteViewModel.swift
//  StamSoftProizvodstvena
//
//  Created by Aleko Georgiev on 20.07.23.
//

import Foundation

class DetailsNoteViewModel: ObservableObject {
    private var notesManager: NotesManager
    @Published var note: Note {
        willSet {
            changed = true
        }
    }
    @Published var changed = false
    @Published var due = Date() {
        willSet {
            note.due = newValue
        }
    }
    
    init(notesManager: NotesManager, note: Note) {
        self.notesManager = notesManager
        self.note = note
    }
    
    func updateNote() {
        notesManager.updateNote(note: note)
    }
}
