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
    var onComplete: () -> Void
    init(note: Note, onComplete: @escaping () -> Void) {
        self.note = note
        self.onComplete = onComplete
        dateFormatter.dateFormat = "MMM d, h:mm a"
    }
    
    var body: some View {
            
            HStack {
                completeButton
                VStack (alignment: .leading) {
                    Text(note.title)
                        .bold()
                        .font(.title3)
                        .foregroundColor(.accentColor)
                    
                    if !note.body.isEmpty {
                        Text(note.body)
                            .lineLimit(2)
                            .foregroundColor(.accentColor)
                            .font(.body)
                    }

                    if note.due != nil {
                        HStack {
                            Image(systemName: "calendar")
                                .font(.body)
                            Text("\(dateFormatter.string(from: note.due!))")
                                .font(.footnote)
                        }
                        .padding(.top, 1)
                        .foregroundColor(.accentColor)
                        .fontWeight(.heavy)
                    }
                }
                Spacer()
            }

        .opacity(note.isCompleted ? 0.4 : 1)
        .fontDesign(.rounded)
    }
    
    @ViewBuilder var completeButton: some View {
        Button {
            onComplete()
        } label: {
            Image(systemName: note.isCompleted ? "checkmark.circle.fill" : "circle")
                .font(.title)
                .foregroundColor(.accentColor)
        }
        .buttonStyle(BorderlessButtonStyle())
    }
    

}

struct NoteCard_Previews: PreviewProvider {
    static var previews: some View {
        NoteCard(note: Note(id: "", title: "asd", body: "aaa", due: Date(), isCompleted: true)) {
            debugPrint("ooga booga")
        }
    }
}
