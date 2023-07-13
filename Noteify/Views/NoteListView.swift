//
//  NotesListView.swift
//  StamSoftProizvodstvena
//
//  Created by Aleko Georgiev on 10.07.23.
//

import SwiftUI

struct NoteListView: View {
    @ObservedObject var noteVM: NoteViewModel
    @State var creating = false
    var body: some View {
        ZStack {
            
            VStack {
                LinearGradient(colors: [.orange, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .mask {
                        Text("Your notes")
                            .bold()
                            .font(.largeTitle)
                            .scaleEffect(1.2)
                            .padding(.bottom)
                    }
                    .frame(maxHeight: 40)
                    .padding(.all)
                
                ZStack {
                    notes
                    plusButton
                        .opacity(creating ? 0 : 1)
                    VStack {
                        Spacer()
                        NoteCreationView(creating: $creating)
                    }
                    .transition(.move(edge: .bottom))
                    .opacity(creating ? 1 : 0)
                }

            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    @ViewBuilder var notes: some View {
        ScrollView {
            VStack {
                ForEach(noteVM.notes) { note in
                    ZStack {
                        NoteCard(note: note)
                        HStack {
                            Spacer()

                            VStack {
                                Button {
                                    noteVM.completeNote(id: note.id)
                                } label: {
                                    Image(systemName: note.isCompleted ? "circle.circle.fill" : "circle")
                                        .animation(.default)
                                        .scaleEffect(2)
                                        .padding(.trailing)

                                }
                                .padding(.trailing)
                                .foregroundColor(.white)
                            }
                            .padding(.trailing)
                        }

                    }
                    .padding(.bottom)
                }
                invisibleElement
            }
            .padding([.top, .bottom])
        }
    }
    
    @ViewBuilder var invisibleElement: some View {
        NoteCard(note: Note(id: -1, title: "", body: "", due: Date(), isCompleted: false))
            .opacity(0)
    }
    
    @ViewBuilder var background: some View {
        LinearGradient(colors: [.purple, .yellow], startPoint: .topLeading, endPoint: .bottomTrailing)
            .opacity(0.4)
            .ignoresSafeArea()
    }
    
    @ViewBuilder var plusButton: some View {
        VStack {
            Spacer()
            
            HStack {
                Button {
                    withAnimation {
                        creating.toggle()
                    }
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
                            .mask {
                                Circle()
                            }
                        )
                        .scaleEffect(1.5)
                        .padding(.all)
                }
                .shadow(radius: 8)
            }
        }
    }
}

struct NotesListView_Previews: PreviewProvider {
    static var previews: some View {
        NoteListView(noteVM: NoteViewModel())
    }
}
