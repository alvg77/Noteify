//
//  NoteView.swift
//  StamSoftProizvodstvena
//
//  Created by Aleko Georgiev on 12.07.23.
//

import SwiftUI

struct NoteView: View {
    @EnvironmentObject var noteVM: NoteViewModel
    var note: Note
    
    var body: some View {
        Text("Hello World")
    }
}

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        let notevm = NoteViewModel()
        NoteView(note: notevm.notes[0])
            .environmentObject(notevm)
    }
}
