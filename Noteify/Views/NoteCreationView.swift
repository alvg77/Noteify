//
//  CreateNewNote.swift
//  StamSoftProizvodstvena
//
//  Created by Aleko Georgiev on 12.07.23.
//

import SwiftUI

struct NoteCreationView: View {
    
    enum SelectedField {
        case title
        case body
        case due
    }
    
    @State var noteTitle = ""
    @State var noteBody = ""
    @State var due: Date = Date()
    
    @Binding var creating: Bool
    
    @FocusState var selected: SelectedField?
    @EnvironmentObject var noteVM: NoteViewModel
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    withAnimation {
                        creating.toggle()
                    }
                } label: {
                    ThemeGradient()
                        .mask {
                            Image(systemName: "x.circle.fill")
                                .scaleEffect(1.4)
                        }
                        .frame(maxWidth: 30, maxHeight: 30)

                }
            }
            ThemeGradient()
                .mask {
                    Text("Create")
                        .bold()
                        .font(.largeTitle)
                }
                .frame(maxHeight: 80)
                
            Group {
                TextField("Note title", text: $noteTitle)
                    .overlay(
                        ThemeGradient()
                            .frame(width: nil, height: 2),
                        alignment: .bottom
                    )
                    .focused($selected, equals: .title)
                TextField("Note title", text: $noteBody, axis: .vertical)
                    .lineLimit(2)
                    .overlay(
                        ThemeGradient()
                            .frame(width: nil, height: 2),
                        alignment: .bottom
                    )
            }
            .font(.title3)
            
            
            DatePicker("Due", selection: $due)
                .bold()
                .padding(.bottom)
            
            Button("Create") {
                
            }
            .foregroundColor(.white)
            .buttonStyle(.borderedProminent)
            
        }
        .padding(.all)
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.white)
                ThemeGradient()
                    .mask {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(lineWidth: 4)
                    }
                    
            }
                .shadow(radius: 20)
                
        )
        .padding(.all)
        
    }
}

//struct CreateNewNote_Previews: PreviewProvider {
//    static var previews: some View {
//        NoteCreationView()
//    }
//}
