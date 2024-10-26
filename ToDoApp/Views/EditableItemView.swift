//
//  EditableItemView.swift
//  ToDoApp
//
//  Created by Jonathan Jacquat on 26.10.2024.
//

import SwiftUI

struct EditableItemView: View {
    @StateObject private var viewModel: EditableItemViewViewModel
    @Binding var itemPresented: Bool
    @Environment(\.modelContext) private var context

    init(viewModel: EditableItemViewViewModel, itemPresented: Binding<Bool>) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self._itemPresented = itemPresented
    }
    
    var body: some View {
        VStack {
            Text(viewModel.isUpdating ? "Update task" : "New task")
                .font(.system(size: 28))
                .bold()
                .padding(.top, 25)
            Form {
                Section("Title") {
                    TextField("Title", text: $viewModel.item.title)
                        .textFieldStyle(DefaultTextFieldStyle())
                }

                Section("Due date") {
                    DatePicker(
                        "Due Date", selection: $viewModel.item.dueDate,
                        displayedComponents: .date
                    )
                    .datePickerStyle(.compact)
                }

                Section("Recurrence") {
                    Picker(
                        selection: $viewModel.item.recursivity.type,
                        label: Text("Recurrence")
                    ) {
                        ForEach(RecursivityEnum.allCases) { recursivity in
                            Text(recursivity.name).tag(recursivity.rawValue)
                        }
                    }
                    .pickerStyle(.menu)
                    Picker(
                        selection: $viewModel.item.recursivity.repeats,
                        label: Text("Repeat")
                    ) {
                        ForEach((0...100), id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.automatic)
                }

                Section("Task priority") {
                    Picker(
                        selection: $viewModel.item.priority,
                        label: Text("Priority")
                    ) {
                        ForEach(Priority.allCases, id: \.self) { priority in
                            Text(priority.name).tag(priority.rawValue)
                        }
                    }
                    .pickerStyle(.menu)
                }

                Button(action: {
                    if viewModel.canSave {
                        viewModel.save(context: context)
                        itemPresented = false
                    } else {
                        viewModel.showAlert = true
                    }
                }) {
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
    EditableItemView(viewModel: EditableItemViewViewModel(), itemPresented: Binding(get: { return true }, set: { _ in }))
}
