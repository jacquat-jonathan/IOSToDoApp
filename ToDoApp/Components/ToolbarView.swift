//
//  ToolbarView.swift
//  ToDoApp
//
//  Created by Jonathan Jacquat on 24.10.2024.
//

import SwiftUI

struct ToolbarView: View {
    @StateObject var viewModel: ToDoListViewViewModel
    @Environment(\.modelContext) private var context

    var toDoListItems: [ToDoListItem]

    var body: some View {
        Button {
            viewModel.showingNewItemView = true
        } label: {
            Image(systemName: "plus.circle")
        }

        Button {
            viewModel.showDeleteAllAlert = true
        } label: {
            Image(systemName: "trash")
        }
        .alert(isPresented: $viewModel.showDeleteAllAlert) {
            Alert(
                title: Text("Delete All Items ?"),
                primaryButton: .destructive(Text("Delete All")) {
                    viewModel.deleteAll(
                        context: context, list: toDoListItems)
                },
                secondaryButton: .cancel()
            )
        }
    }
}

#Preview {
    ToolbarView(viewModel: ToDoListViewViewModel(), toDoListItems: [])
}
