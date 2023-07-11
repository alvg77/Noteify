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
    @Published var notes: [NoteModel] = [
        NoteModel(id: 1, title: "asd", body: "123", due: Date(), isCompleted: false)
    ]
    
    func addNote() {
        
    }
    
    func deleteNote() {
        
    }
    
    
}
