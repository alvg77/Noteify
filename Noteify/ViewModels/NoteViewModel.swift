//
//  NoteViewModel.swift
//  StamSoftProizvodstvena
//
//  Created by Aleko Georgiev on 10.07.23.
//

import Foundation

class NoteViewModel: ObservableObject {
    @Published var noteName: String = ""
    @Published var noteBody: String = ""
    @Published var noteDue: String?
    @Published var notes: [Note] = [
        Note(id: 1, title: "asd", body: "123", due: Date(), isCompleted: false),
        Note(id: 2, title: "asd", body: "123", due: Date(), isCompleted: false),
        Note(id: 3, title: "asd", body: "123", due: Date(), isCompleted: false),
        Note(id: 4, title: "asd", body: "123", due: Date(), isCompleted: false),
        Note(id: 5, title: "asd", body: "123", due: Date(), isCompleted: false),        
    ]
    
    func completeNote(id: Int) {
        for i in notes.indices {
            if notes[i].id == id {
                notes[i].isCompleted.toggle()
            }
        }
    }
    
    func addNote() {
        
    }
    
    func deleteNote() {
        
    }
    
    
}
