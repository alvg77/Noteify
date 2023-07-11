//
//  NotesListView.swift
//  StamSoftProizvodstvena
//
//  Created by Aleko Georgiev on 10.07.23.
//

import SwiftUI

struct NotesListView: View {
    @ObservedObject var noteVM: NoteViewModel
    var body: some View {
        ZStack {
            background
            VStack {
                LinearGradient(colors: [.orange, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .mask {
                        Text("Your notes")
                            .bold()
                            .font(.largeTitle)
                            .scaleEffect(1.2)
                    }
                    .frame(maxHeight: 30)
                    .padding(.all)
                

                ScrollView {
                    VStack {
                        ForEach(noteVM.notes) { note in
                            VStack (alignment: .leading) {
                                Text(note.title)
                                    .font(.largeTitle)
                                    .foregroundColor(.white)
                                Text(note.body)
                                    .font(.body)
                                HStack {
                                    Text("\(note.createdAt)")
                                        .font(.footnote)
                                    Spacer()
                                    Text("\(note.due)")
                                        .font(.footnote)
                                }
                            }
                        }
                    }
                }
               plusButton
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    @ViewBuilder var background: some View {
        LinearGradient(colors: [.purple, .yellow], startPoint: .topLeading, endPoint: .bottomTrailing)
            .opacity(0.4)
            .ignoresSafeArea()
    }
    
    @ViewBuilder var plusButton: some View {
        HStack {
            Spacer()
            Button {
            
            } label: {
                Text("+")
                    .font(.largeTitle)
                    .padding(.all)
                    .foregroundColor(.white)
                    .background(
                        LinearGradient(
                            colors: [.yellow, .purple],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                            .mask({
                                Circle()
                            })
                    )
                    .scaleEffect(1.5)
                    .padding(.all)
            }
            .padding(.all)
            .shadow(radius: 8)
        }
    }
}

struct NotesListView_Previews: PreviewProvider {
    static var previews: some View {
        NotesListView(noteVM: NoteViewModel())
    }
}
