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
        ZStack {
            HStack {
                completeButton
                VStack (alignment: .leading) {
                    Text(note.title)
                        .bold()
                        .font(.largeTitle)
                        .foregroundColor(Color("color.theme"))
                    
                    Text(note.body)
                        .lineLimit(2)
                        .foregroundColor(Color("color.theme"))
                        .font(.title3)
                    
                    Divider()
                        .frame(height: 2)
                        .overlay(Color("color.theme"))
                    
                    HStack {
                        Image(systemName: "calendar")
                            .font(.body)
                        Text("\(dateFormatter.string(from: Date()))")
                            .font(.footnote)
                    }
                    .foregroundColor(Color("color.theme"))
                    .fontWeight(.heavy)
                }
                Spacer()
            }
            .padding(.all)
        }
        .fontDesign(.rounded)
        .padding(.horizontal)
    }
    
    @ViewBuilder var completeButton: some View {
        Button {
            onComplete()
        } label: {
            Image(systemName: note.isCompleted ? "checkmark.circle.fill" : "circle")
                .font(.title)
                .foregroundColor(Color("color.theme"))
        }
    }
    
}

struct NoteCard_Previews: PreviewProvider {
    static var previews: some View {
        NoteCard(note: Note(id: "", title: "asd", body: "aaa", due: Date(), isCompleted: true)) {
            debugPrint("ooga booga")
        }
    }
}
