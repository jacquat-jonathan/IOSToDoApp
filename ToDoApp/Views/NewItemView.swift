//
//  NewItemView.swift
//  TestApp
//
//  Created by Jonathan Jacquat on 14.10.2024.
//

import SwiftData
import SwiftUI

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

    func isButtonActive(_ priority: Priority) -> Bool {
        return priority == viewModel.priority
    }

    @State private var selectedPriorityIndex: Int = 2  // Store the selected priority index
    //@State private var selectedPriority: Priority = .medium // Store the selected priority enum

    var body: some View {
        VStack {
            Text("New Item")
                .font(.system(size: 28))
                .bold()
                .padding(.top, 25)
            Form {
                Section("Title") {
                    TextField("Title", text: $viewModel.title)
                        .textFieldStyle(DefaultTextFieldStyle())
                }
                Section("Due date") {
                    DatePicker(
                        "Due Date", selection: $viewModel.dueDate,
                        displayedComponents: .date
                    )
                    .datePickerStyle(GraphicalDatePickerStyle())
                }
                Section("Task priority") {
                    VStack {
                        Slider(
                            value: Binding(
                                get: { Double(selectedPriorityIndex) },
                                set: { newValue in
                                    selectedPriorityIndex = Int(newValue)
                                    viewModel.priority =
                                        Priority(
                                            rawValue: selectedPriorityIndex)
                                        ?? .medium
                                }
                            ), in: 1...4, step: 1)
                        HStack {
                            ForEach(Priority.allCases, id: \.self) { priority in
                                Text(priority.name)
                                    .fontWeight(
                                        viewModel.priority == priority
                                            ? .bold : .regular
                                    )
                                    .frame(maxWidth: .infinity)
                            }
                        }
                    }
                }

                Button(
                    action: {
                        if viewModel.canSave {
                            viewModel.save(context: context)
                            newItemPresented = false
                        } else {
                            viewModel.showAlert = true
                        }
                    }
                ) {
                    Text("Save")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(PlainButtonStyle())
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text(
                        "Please fill in all fields and select due date that is today or newer."
                    ))
            }
        }
    }
}

#Preview {
    NewItemView(newItemPresented: Binding(get: { return true }, set: { _ in }))
        .modelContainer(for: ToDoListItem.self, inMemory: true)
}
