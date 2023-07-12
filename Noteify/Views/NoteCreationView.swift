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
    
    @FocusState var selected: SelectedField?
    @EnvironmentObject var noteVM: NoteViewModel
    
    var body: some View {
        VStack {
            title
            inputFields
            createButton
        }
        .padding(.all)
        .background(
            background
        )
        .padding(.all)
        
    }
    
    @ViewBuilder var title: some View {
        ThemeGradient()
            .mask {
                Text("Create")
                    .bold()
                    .font(.largeTitle)
            }
            .frame(maxHeight: 80)
    }
    
    @ViewBuilder var inputFields: some View {
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
        .padding(.bottom)
        
        DatePicker("Due", selection: $due)
            .bold()
            .padding(.bottom)
    }
    
    @ViewBuilder var createButton: some View {
        Button("Create") {
            
        }
        .foregroundColor(.white)
        .buttonStyle(.borderedProminent)
    }
    
    @ViewBuilder var background: some View {
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
    }
    
}

//struct CreateNewNote_Previews: PreviewProvider {
//    static var previews: some View {
//        NoteCreationView()
//    }
//}
