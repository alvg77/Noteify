//
//  NoteCard.swift
//  StamSoftProizvodstvena
//
//  Created by Aleko Georgiev on 11.07.23.
//

import SwiftUI

struct NoteCard: View {
    var dateFormatter = DateFormatter()
    var note: NoteModel
    
    init(note: NoteModel) {
        self.note = note
        dateFormatter.dateFormat = "MMM d, h:mm a"
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(lineWidth: 2.5)
                    .foregroundColor(.white)
                    .background(
                        ZStack {
                            Color.gray
                                .cornerRadius(20)
                                .opacity(0.4)
                            LinearGradient(colors: [.yellow, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
                                .cornerRadius(20)
                                .opacity(0.6)
                        }
                    )
                    .shadow(radius: 4)
                    .frame(maxHeight: geometry.size.height / 5)
                    
                HStack {
                    VStack (alignment: .leading) {
                        Text(note.title)
                            .bold()
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .padding(.top)
                        
                            Text(note.body)
                            .lineLimit(2)
                            .foregroundColor(.white)
                            .font(.title3)


                        
                        Text("\(dateFormatter.string(from: Date()))")
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .bold()
                            .padding(.vertical)
                    }

                    Spacer()
                    Button {
                    } label: {
                        let maxSize = geometry.size.height < geometry.size.width ? geometry.size.height / 6 : geometry.size.width / 6
                        
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(lineWidth: 4)
                            .padding(.all)
                            .frame(maxWidth: maxSize, maxHeight: maxSize)
                        
                    }
                    .foregroundColor(.white)
                }
                .padding(.all)
            }
            .padding(.all)
        }
    }
}

struct NoteCard_Previews: PreviewProvider {
    static var previews: some View {
        NoteCard(note: NoteModel(id: 1, title: "asd", body: "123asfdafdasfafddaffadsfasdfadsfasdfadfadsfsadfadsfsdafdsfdsafdsafdsafsdafsdafasdfdsa", due: Date(), isCompleted: false))
    }
}
