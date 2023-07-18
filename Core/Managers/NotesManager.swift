//
//  NoteManager.swift
//  StamSoftProizvodstvena
//
//  Created by Aleko Georgiev on 13.07.23.
//

import Foundation
import Firebase
import Combine

class NotesManager: ObservableObject {
    func fetchNotes(currentUser: User?) -> AnyPublisher<[Note], Error> {
        let db = Firestore.firestore()
        
        let publisher = PassthroughSubject<[Note], Error>()
        
        if let currentUser {
            let ref = db.collection("Notes").whereField("ownerEmail", isEqualTo: currentUser.email)
            ref.addSnapshotListener { snapshot, error in
                guard error == nil else {
                    /*------------------------------*/
                    // TODO: handle errors adequately
                    /*------------------------------*/
                    debugPrint("\(error!.localizedDescription)")
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    debugPrint("no documents")
                    return
                }
                
                publisher.send(
                    documents.map { queryDocumentSnapshot in
                        let data = queryDocumentSnapshot.data()
                        
                        let id = queryDocumentSnapshot.documentID
                        let title = data["title"] as? String ?? ""
                        let body = data["body"] as? String ?? ""
                        let due = data["due"] as? Timestamp
                        let isCompleted = data["isCompleted"] as? Bool ?? false
                        let createdAt = data["createdAt"] as? Date ?? Date()
                        
                        return Note(id: id, title: title, body: body, due: due?.dateValue(), isCompleted: isCompleted, createdAt: createdAt)
                    }
                )
            }
        }
        
        return publisher.eraseToAnyPublisher()
    }
    
    
    func addNote(currentUser: User?, note: Note) {
        let db = Firestore.firestore()
        let id = UUID().uuidString
        let ref = db.collection("Notes").document(id)
        if let currentUser {
            var data = [
                "title": note.title,
                "body": note.body,
                "createdAt": note.createdAt,
                "isCompleted": note.isCompleted,
                "ownerEmail": currentUser.email
            ] as [String : Any]
            
            if let due = note.due {
                data["due"] = due
            }
            
            ref.setData(data) { error in
                if let error {
                    debugPrint("\(error.localizedDescription)")
                }
            }
        }
    }
    
    func updateNote(note: Note) {
        let db = Firestore.firestore()
        let ref = db.collection("Notes").document(note.id)
        
        var data = [
            "title": note.title,
            "body": note.body,
            "isCompleted": note.isCompleted
        ] as [String : Any]
        
        if let due = note.due {
            data["due"] = note.due
        }
        
        ref.updateData(data) { error in
            if let error {
                debugPrint("\(error.localizedDescription)")
            }
        }
        
    }
    
    func deleteNote(id: String) {
        let db = Firestore.firestore()
        let ref = db.collection("Notes").document(id)
        ref.delete { error in
            if let error {
                debugPrint("\(error.localizedDescription)")
            }
        }
    }
    
    func updateCompletion(id: String, completion: Bool) {
        let db = Firestore.firestore()
        let ref = db.collection("Notes").document(id)
        ref.updateData(["isCompleted": completion]) { error in
            if let error {
                debugPrint("\(error.localizedDescription)")
            }
        }
    }
}

