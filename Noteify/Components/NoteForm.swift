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
    private var completeDisableCondition: Bool
    private let closeAlert: Alert
        
    init(heading: String, note: Binding<Note>, completeDisableCondition: Bool = false, due:  Binding<Date>, shouldAlert: Binding<Bool> = Binding.constant(true), closeAlert: Alert, onComplete: @escaping ()->Void) {
        self._note = note
        self._due = due
        self.headingValue = heading
        self.closeAlert = closeAlert
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
                topper
                    .padding(.all)
                Form {
                    Section {
                        inputFields
                    }
                    Section {
                        datePicker
                    }
                }
                .scrollDismissesKeyboard(.interactively)
            }
        }
        .fontDesign(.rounded)
        
    }
    
    @ViewBuilder var topper: some View {
        HStack {
            Button("Close") {
                isConfirmingClose = true && shouldAlert
                if !isConfirmingClose {
                    dismiss()
                }
            }
            .alert(isPresented: $isConfirmingClose) {
                closeAlert
            }
            
            Spacer()
            
            title
            
            Spacer()
            
            Button("Done") {
                onComplete()
                dismiss()
            }
            .disabled(completeDisableCondition)
        }
        
    }
    
    @ViewBuilder var title: some View {
        Text(headingValue)
            .fontWeight(.heavy)
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
                VStack(alignment: .leading) {
                    Text("Date")
                    if isOnDate {
                        Text("\(dateFormatter.string(from: due))")
                            .foregroundColor(.accentColor)
                    }
                }
            }
            .frame(height: 36)
            .transaction { transaction in
                transaction.animation = nil
            }
        }
        .onChange(of: isOnDate) { newValue in
                if !newValue {
                    isOnTime = false
                    hiddenDate = true
                } else if !isOnTime {
                    withAnimation {
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
                VStack(alignment: .leading) {
                    Text("Time")
                    if isOnTime {
                        Text("\(timeFormatter.string(from: due))")
                            .foregroundColor(.accentColor)
                    }
                }
            }
            .frame(height: 36)

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
                    hiddenDate = true
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
