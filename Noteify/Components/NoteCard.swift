//
//  NoteCard.swift
//  StamSoftProizvodstvena
//
//  Created by Aleko Georgiev on 11.07.23.
//

import SwiftUI

struct NoteCard: View {
    var dateFormatter = DateFormatter()
    var note: Note
    
    @ObservedObject var noteVM: NoteViewModel
    
    init(note: Note, noteVM: NoteViewModel) {
        self.note = note
        self.noteVM = noteVM
        dateFormatter.dateFormat = "MMM d, h:mm a"
    }
    
    var body: some View {
        ZStack {
            cardContent
            .background {
                cardBackground
            }
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder var cardContent: some View {
        HStack {
            completeButton
                .padding(.trailing)
            
            VStack (alignment: .leading) {
                Text(note.title)
                    .bold()
                    .font(.largeTitle)
                Text("\(dateFormatter.string(from: Date()))")
                    .font(.footnote)
                    .bold()
                    .opacity(0.65)
            }
            Spacer()
        }
        .foregroundColor(.cyan)
        .padding(.all)
    }
    
    @ViewBuilder var completeButton: some View {
        Button {
            noteVM.completeNote(id: note.id)
        } label: {
            ZStack {
                if note.isCompleted {
                    Image(systemName: "checkmark.circle.fill")
                        .scaleEffect(1.4)
                } else {
                    Image(systemName: "circle")
                        .scaleEffect(1.4)
                }

            }
        }
    }

    @ViewBuilder var cardBackground: some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundColor(.white)
            .shadow(radius: 4)
    }
    
}

struct NoteCard_Previews: PreviewProvider {
    static var previews: some View {
        let notevm = NoteViewModel()
        NoteCard(note: notevm.notes[0], noteVM: NoteViewModel())
    }
}
