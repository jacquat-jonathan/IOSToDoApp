//
//  ArchiveView.swift
//  TestApp
//
//  Created by Jonathan Jacquat on 18.10.2024.
//

import SwiftData
import SwiftUI

struct ArchiveView: View {
    @StateObject private var viewModel = ToDoListViewViewModel()
    @Environment(\.modelContext) private var context

    // List des items archivés
    @Query(
        filter: #Predicate<ToDoListItem> { item in
            item.isArchived
        }) private var archivedItems: [ToDoListItem]

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List(archivedItems) { item in
                    ToDoListItemView(item: item, disabled: true)
                        .swipeActions {
                            Button("Delete") {
                                viewModel.delete(context: context, item: item)
                            }
                            .tint(.red)

                            Button("Restore") {
                                viewModel.setArchive(
                                    context: context, item: item)
                            }
                            .tint(.blue)
                        }
                }
            }
            .navigationTitle("Archive")
            .toolbar {
                ToolbarItemGroup {
                    Button {
                        // Pick a task then show update view (same as new but with task values)
                        viewModel.showRestoreAllAlert = true
                    } label: {
                        Image(systemName: "arrow.3.trianglepath")
                    }
                    .alert(isPresented: $viewModel.showRestoreAllAlert) {
                        Alert(
                            title: Text("Restore All Items ?"),
                            primaryButton: .destructive(Text("Restore All")) {
                                viewModel.restoreAll(
                                    context: context, list: archivedItems)
                            },
                            secondaryButton: .cancel()
                        )
                    }

                    Button {
                        // Pick a task then show update view (same as new but with task values)
                        viewModel.showDeleteAllAlert = true
                    } label: {
                        Image(systemName: "trash")
                    }
                    .alert(isPresented: $viewModel.showDeleteAllAlert) {
                        Alert(
                            title: Text("Delete All Items ?"),
                            primaryButton: .destructive(Text("Delete All")) {
                                viewModel.deleteAll(
                                    context: context, list: archivedItems)
                            },
                            secondaryButton: .cancel()
                        )
                    }
                }
            }
        }
    }
}

#Preview {
    ArchiveView()
        .modelContainer(for: ToDoListItem.self, inMemory: true)
}
