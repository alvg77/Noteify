//
//  CreateNewNote.swift
//  StamSoftProizvodstvena
//
//  Created by Aleko Georgiev on 12.07.23.
//

import SwiftUI

struct NewNoteView: View {
    
    enum SelectedField {
        case title
        case body
        case due
    }
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var userManager: UsersManager
    
    @StateObject var noteVM: NewNoteViewModel
    @FocusState var selected: SelectedField?
    @State var isConfirmingClose: Bool = false
    
    var body: some View {
        ZStack {
            Color("color.background")
                .ignoresSafeArea()
            ScrollView {
                VStack {
                    buttons
                        .padding(.all)
                    title
                        .padding(.all)
                    inputFields
                    datePicker
                    Spacer()
                }
            }
            
        }
        .fontDesign(.rounded)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") {
                    selected = .none
                }
            }
        }
        
    }
    
    @ViewBuilder var buttons: some View {
        HStack {
            Button("Close") {
                noteVM.refreshNote()
                isConfirmingClose = true
            }
            .alert(isPresented: $isConfirmingClose) {
                closeAlert
            }
            
            Spacer()
            
            Button("Create") {
                noteVM.addNote(currentUser: userManager.currentUser)
                dismiss()
            }
            .disabled(!noteVM.isValid)
        }
        
    }
    
    var closeAlert: Alert {
        Alert(
            title: Text("You have unsaved changes"),
            message: Text("Are you sure you want to discard the currnet note?"),
            primaryButton: .default(Text("Cancel")),
            secondaryButton: .destructive(Text("Close")) {
                dismiss()
            }
        )
    }
    
    @ViewBuilder var title: some View {
        Text("Create note")
            .font(.system(size: 44, weight: .heavy))
            .bold()
            .foregroundColor(Color("color.theme"))
    }
    
    @ViewBuilder var inputFields: some View {
        Group {
            TextField("Note title", text: $noteVM.note.title)
                .focused($selected, equals: .title)
            TextField("Note body", text: $noteVM.note.body, axis: .vertical)
                .lineLimit(5, reservesSpace: true)
                .focused($selected, equals: .body)
        }
        .padding(.all)
        .background(
            RoundedRectangle(cornerRadius: 4)
                .foregroundColor(Color("color.element"))
        )
        .padding(.horizontal)
        .font(.title3)
    }
    
    @ViewBuilder var datePicker: some View {
        DatePicker("DUE", selection: $noteVM.note.due)
            .padding(.horizontal)
            .fontWeight(.heavy)
            .foregroundColor(Color("color.theme"))
            .tint(Color("color.theme"))
            .padding(.horizontal)
            .focused($selected, equals: .due)
    }
}
