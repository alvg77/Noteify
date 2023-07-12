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
                ThemeGradient()
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
                        NoteCard(note: note, noteVM: noteVM)
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
            }
            .padding([.top, .bottom])
        }
    }
    
    @ViewBuilder var plusButton: some View {
        VStack {
            Spacer()
            
            HStack {
                Spacer()
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
                                Circle()
                                    .foregroundColor(.cyan)
                        )
                        .scaleEffect(1.5)
                        .padding(.all)
                }
                .padding(.trailing)
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
