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
            viewModel.showMoveOverdueAlert = true
        } label: {
            Image(systemName: "calendar.badge.clock.rtl")
        }
        .alert(isPresented: $viewModel.showMoveOverdueAlert) {
            Alert(
                title: Text("Move all overdue items to today ?"),
                primaryButton: .destructive(Text("Move")) {
                    viewModel.movePassedTasks(
                        context: context, list: toDoListItems)
                },
                secondaryButton: .cancel()
            )
        }

        Button {
            viewModel.showDoneTasksRemover = true
        } label: {
            Image(systemName: "checkmark.gobackward")
        }
        .alert(
            "Remove done tasks ?", isPresented: $viewModel.showDoneTasksRemover
        ) {
            Button(
                "Delete", role: .destructive,
                action: {
                    viewModel.deleteAll(
                        context: context,
                        list: toDoListItems.filter({ $0.isDone }))
                })
            Button(
                "Archive",
                action: {
                    viewModel.archiveAll(
                        context: context,
                        list: toDoListItems.filter({ $0.isDone }))
                })
            Button("Cancel", role: .cancel, action: {})
        }

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
