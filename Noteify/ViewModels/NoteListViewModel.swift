//
//  NoteViewModel.swift
//  StamSoftProizvodstvena
//
//  Created by Aleko Georgiev on 10.07.23.
//

import Foundation
import Combine

class NoteListViewModel: ObservableObject {
    private var noteManager: NotesManager
    
    init(noteManager: NotesManager) {
        self.noteManager = noteManager
    }
    
    @Published var notes: [Note] = []
    private var cancellables = Set<AnyCancellable>()

    func fetchNotes(currentUser: User?) {
        cancellables.insert(
            noteManager.fetchNotes(currentUser: currentUser)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        print("Finished")
                    case .failure(let error):
                        print("Error: \(error.localizedDescription)")
                    }
                }, receiveValue: { [weak self] notes in
                    self?.notes = notes
                })
        )
    }
    
    func updateCompletion(id: String) {
        if let completion = notes.first(where: {$0.id == id})?.isCompleted {
            noteManager.updateCompletion(id: id, completion: !completion)
        }
    }
    
    func deleteNote(index: Int) {
        noteManager.deleteNote(id: notes[index].id)
    }    
}
