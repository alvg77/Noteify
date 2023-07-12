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
    
    init(note: Note) {
        self.note = note
        dateFormatter.dateFormat = "MMM d, h:mm a"
    }
    
    var body: some View {
        ZStack {
            HStack {
                VStack (alignment: .leading) {
                    Text(note.title)
                        .bold()
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    
                        Text(note.body)
                        .lineLimit(2)
                        .foregroundColor(.white)
                        .font(.title3)


                    
                    Text("\(dateFormatter.string(from: Date()))")
                        .font(.footnote)
                        .foregroundColor(.white)
                        .bold()
                }
                
                Spacer()

                //                    Button {
//                    } label: {
//                        RoundedRectangle(cornerRadius: 12)
//                            .stroke(lineWidth: 4)
//                            .background(
//                                RoundedRectangle(cornerRadius: 12)
//                                    .scaleEffect(1/2)
//                            )
//                    }
//                    .foregroundColor(.white)
            }
            .padding(.all)
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(lineWidth: 2.5)
                    .foregroundColor(.white)
                    .background(
                        ZStack {
                            Color.gray
                                .cornerRadius(20)
                                .opacity(0.4)
                            LinearGradient(colors: [.orange, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
                                .cornerRadius(20)
                                .opacity(0.6)
                        }
                    )
                    .shadow(radius: 4)
            }
        }
        .padding(.horizontal)
    }
    
}

struct NoteCard_Previews: PreviewProvider {
    static var previews: some View {
        NoteCard(note: Note(id: 1, title: "asd", body: "aaa", due: Date(), isCompleted: false))
    }
}
