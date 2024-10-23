//
//  NewItemView.swift
//  TestApp
//
//  Created by Jonathan Jacquat on 14.10.2024.
//

import SwiftUI
import SwiftData

struct UpdateItemView: View {
    @StateObject private var viewModel: UpdateItemViewViewModel
    @Binding var updateItemPresented: Bool
    
    @Environment(\.modelContext) private var context
    
    init(item: ToDoListItem, updateItemPresented: Binding<Bool>) {
        self._updateItemPresented = updateItemPresented
        self._viewModel = StateObject(wrappedValue: UpdateItemViewViewModel(item: item))
    }

    var body: some View {
        VStack {
            Text("Update Item")
                .font(.system(size: 32))
                .bold()
                .padding(.top, 50)
            Form {
                TextField("Title", text: $viewModel.itemToUpdate.title)
                    .textFieldStyle(DefaultTextFieldStyle())
                
                DatePicker("Due Date", selection: $viewModel.itemToUpdate.dueDate, displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                
                Button("Save") {
                    if viewModel.canSave {
                        viewModel.update(context: context)
                        updateItemPresented = false
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
        .onAppear {
            viewModel.loadCurrentItem()
        }
    }
}

#Preview {
    UpdateItemView(item: ToDoListItem(), updateItemPresented: Binding(get: { return true }, set: { _ in }))
        .modelContainer(for: ToDoListItem.self, inMemory: true)
}
