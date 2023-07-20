//
//  CreateNewNote.swift
//  StamSoftProizvodstvena
//
//  Created by Aleko Georgiev on 12.07.23.
//

import SwiftUI

struct NewNoteView: View {
    
    enum SelectedField {
        case title
        case body
        case due
    }
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var userManager: UsersManager
    
    @StateObject var noteVM: NewNoteViewModel
    @FocusState var selected: SelectedField?
    @State var isConfirmingClose: Bool = false
    
    var body: some View {
        NoteForm(heading: "New Note", note: $noteVM.note, completeDisableCondition: !noteVM.isValid, due: $noteVM.due, closeAlert: closeAlert) {
            noteVM.addNote(currentUser: userManager.currentUser)
        }
    }
    
    var closeAlert: Alert {
        Alert(
            title: Text("You have unsaved changes"),
            message: Text("Are you sure you want to discard the currnet note?"),
            primaryButton: .default(Text("Cancel")),
            secondaryButton: .destructive(Text("Close")) {
                dismiss()
                noteVM.refreshNote()
            }
        )
    }
}
