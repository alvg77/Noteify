//
//  NoteView.swift
//  StamSoftProizvodstvena
//
//  Created by Aleko Georgiev on 18.07.23.
//

import SwiftUI

struct DetailsNoteView: View {
    
    enum SelectedField {
        case title
        case body
        case due
    }
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var userManager: UsersManager
    @StateObject var noteVM: DetailsNoteViewModel

    
    var body: some View {
        NoteForm(heading: "Details", note: $noteVM.note, due: $noteVM.due, shouldAlert: $noteVM.changed, closeAlert: closeAlert) {
            noteVM.updateNote()
        } onCancel: {
            debugPrint("closing")
        }
    }
    
    var closeAlert: Alert {
        Alert(
            title: Text("You have unsaved changes"),
            message: Text("Are you sure you want to discard edits on the note?"),
            primaryButton: .default(Text("Cancel")),
            secondaryButton: .destructive(Text("Close")) {
                dismiss()
            }
        )
    }
}
