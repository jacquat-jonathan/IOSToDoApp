//
//  NewItemView.swift
//  TestApp
//
//  Created by Jonathan Jacquat on 14.10.2024.
//

import SwiftUI
import SwiftData

struct NewItemView: View {
    @StateObject private var viewModel = NewItemViewViewModel()
    @Binding var newItemPresented: Bool
    
    @Environment(\.modelContext) private var context

    /*
     Date picker styles
     - WheelDatePickerStyle
     - CompactDatePickerStyle
     - DefaultDatePickerStyle
     - GraphicalDatePickerStyle
     */

    /*
     Button styles
     - PlainButtonStyle
     - BorderedButtonStyle
     - DefaultDatePickerStyle
     - BorderlessButtonStyle
     - BorderedProminentButtonStyle
     */
    
    /*
     Text Field styles
     - PlainTextFieldStyle
     - RoundedBorderTextFieldStyle
     - DefaultTextFieldStyle
     */
    
    var body: some View {
        VStack {
            Text("New Item")
                .font(.system(size: 32))
                .bold()
                .padding(.top, 50)
            Form {
                TextField("Title", text: $viewModel.title)
                    .textFieldStyle(DefaultTextFieldStyle())
                DatePicker("Due Date", selection: $viewModel.dueDate, displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                Button("Save") {
                    if viewModel.canSave {
                        viewModel.save(context: context)
                        newItemPresented = false
                    } else {
                        viewModel.showAlert = true
                    }
                }
                .buttonStyle(BorderedProminentButtonStyle())
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Error"), message: Text("Please fill in all fields and select due date that is today or newer."))
            }
        }
    }
}

#Preview {
    NewItemView(newItemPresented: Binding(get: { return true }, set: { _ in }))
        .modelContainer(for: ToDoListItem.self, inMemory: true)
}
