//
//  NoteForm.swift
//  StamSoftProizvodstvena
//
//  Created by Aleko Georgiev on 19.07.23.
//

import SwiftUI

struct NoteForm: View {
    enum SelectedField {
        case title
        case body
        case due
    }
    
    @Environment(\.dismiss) var dismiss
    
    var headingValue: String
    
    @FocusState var selected: SelectedField?
    
    
    @Namespace var datePickerAnimation
    
    @State private var isConfirmingClose: Bool = false
    
    @State private var isOnDate = false
    @State private var isOnTime = false
    @State private var hiddenDate = true
    @State private var hiddenTime = true
    
    @Binding var note: Note
    @Binding var due: Date
    @Binding var shouldAlert: Bool
    
    private var dateFormatter = DateFormatter()
    private var timeFormatter = DateFormatter()
    
    private var onComplete: () -> Void
    private var onCancel: () -> Void
    private var completeDisableCondition: Bool
    private let closeAlert: Alert
        
    init(heading: String, note: Binding<Note>, completeDisableCondition: Bool = false, due:  Binding<Date>, shouldAlert: Binding<Bool> = Binding.constant(true), closeAlert: Alert, onComplete: @escaping ()->Void, onCancel: @escaping ()->Void) {
        self._note = note
        self._due = due
        self.headingValue = heading
        self.closeAlert = closeAlert
        self.onCancel = onCancel
        self.onComplete = onComplete
        self.completeDisableCondition = completeDisableCondition
        self._shouldAlert = shouldAlert
        dateFormatter.dateFormat = "dd EEE"
        timeFormatter.dateFormat = "hh:mm"
    }
    
    var body: some View {
        ZStack {
            Color("color.background")
                .ignoresSafeArea()
            VStack {
                buttons
                    .padding(.all)
                heading
                    .padding(.all)
                Form {
                    Section {
                        inputFields
                    }
                    Section {
                        datePicker
                    }
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
                onCancel()
                isConfirmingClose = true && shouldAlert
                if !isConfirmingClose {
                    dismiss()
                }
            }
            .alert(isPresented: $isConfirmingClose) {
                closeAlert
            }
            
            Spacer()
            
            Button("Done") {
                onComplete()
                dismiss()
            }
            .disabled(completeDisableCondition)
        }
        
    }
    
    @ViewBuilder var heading: some View {
        Text(headingValue)
            .font(.system(size: 44, weight: .heavy))
            .bold()
            .foregroundColor(.accentColor)
    }
    
    @ViewBuilder var inputFields: some View {
        Group {
            TextField("Note title", text: $note.title)
                .focused($selected, equals: .title)
                .font(.title)
                .padding(.vertical)
            TextField("Note body", text: $note.body, axis: .vertical)
                .focused($selected, equals: .body)
        }
        .font(.title3)
    }
    
    @ViewBuilder var datePicker: some View {
        Toggle(isOn: $isOnDate.animation()) {
            HStack {
                Image(systemName: "calendar")
                VStack (alignment: .leading) {
                    Text("Date")
                    if isOnDate {
                        Text("\(dateFormatter.string(from: due))")
                        
                    }
                }
            }
            .transaction { transaction in
                transaction.animation = nil
            }
        }
        .onChange(of: isOnDate) { newValue in
            withAnimation {
                if !newValue {
                    isOnTime = false
                    hiddenDate = true
                } else if !isOnTime {
                    hiddenDate = false
                }
            }
        }
        .onTapGesture {
            if isOnDate {
                withAnimation {
                    hiddenDate.toggle()
                    if !hiddenTime {
                        hiddenTime.toggle()
                    }
                    debugPrint("ooga booga")
                }
            }
        }
        
        
        if isOnDate && !hiddenDate {
            DatePicker("Due Date", selection: $due, displayedComponents: .date)
                .datePickerStyle(.graphical)
                .transition(.opacity)
        }
        
        
        Toggle(isOn: $isOnTime.animation()) {
            HStack {
                Image(systemName: "clock")
                VStack (alignment: .leading) {
                    Text("Time")
                    if isOnTime {
                        Text("\(timeFormatter.string(from: due))")
                    }
                }
            }
            .transaction { transaction in
                transaction.animation = nil
            }
        }
        .onChange(of: isOnTime) { newValue in
            if newValue {
                withAnimation {
                    isOnDate = true
                    if !hiddenDate {
                        hiddenDate = true
                    }
                    hiddenTime = !newValue
                }
            }
        }
        .onTapGesture {
            if isOnTime {
                withAnimation {
                    if !hiddenDate {
                        hiddenDate.toggle()
                    }
                    hiddenTime.toggle()
                }
            }
        }
        
        if isOnTime && !hiddenTime {
            DatePicker("Due Time", selection: $due, displayedComponents: [.hourAndMinute])
                .datePickerStyle(.wheel)
                .labelsHidden()
        }
    }
    
}
