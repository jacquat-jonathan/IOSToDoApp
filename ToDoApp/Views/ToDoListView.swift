//
//  ToDoListItemView.swift
//  TestApp
//
//  Created by Jonathan Jacquat on 14.10.2024.
//

/*
 ListStyles :
 - PlainListStyle
 - InsetListStyle
 - GroupedListStyle
 - SidebarListStyle
 - InsetGroupedListStyle
 */

import SwiftData
import SwiftUI

struct ToDoListView: View {
    @StateObject private var viewModel = ToDoListViewViewModel()
    @Environment(\.modelContext) private var context


    // Liste des items non archivés
    @Query(
        filter: #Predicate<ToDoListItem> { item in
            !item.isArchived
        }, sort: \ToDoListItem.dueDate) private var toDoListItems: [ToDoListItem]

    func getOrderMessage() -> String {
        switch viewModel.sortOption {
        case .dueDate:
            if viewModel.sortOrder == .forward {
                return "Sorted by due date ascending"
            } else {
                return "Sorted by due date descending"
            }
        case .title:
            return "Sorted by title ascending"
        }
    }

    func getItems() -> [ToDoListItem] {
        switch viewModel.sortOption {
        case .dueDate:
            if viewModel.sortOrder == .forward {
                return toDoListItems.sorted(by: { $0.dueDate < $1.dueDate })
            } else {
                return toDoListItems.sorted(by: { $0.dueDate > $1.dueDate })
            }
        case .title:
            return toDoListItems.sorted(by: { $0.title < $1.title })
        }
    }

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List(getItems()) { item in
                    ToDoListItemView(item: item)
                        .swipeActions {
                            Button("Delete") {
                                viewModel.delete(
                                    context: context, item: item)
                            }
                            .tint(.red)
                            Button("Update") {
                                viewModel.itemToUpdate = item
                                viewModel.showingUpdateItemView = true
                            }.tint(.blue)
                            Button("Archive") {
                                viewModel.setArchive(
                                    context: context, item: item)
                            }
                        }
                }
                .listStyle(InsetGroupedListStyle())
            }
            .navigationTitle("To Do List")
            .toolbar {
                ToolbarItemGroup {
                    Button {
                        viewModel.switchOrder()
                        withAnimation {
                            viewModel.isPopOverPresented = true
                        }
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                    }
                    .popover(isPresented: $viewModel.isPopOverPresented) {
                        Text(getOrderMessage())
                            .padding()
                            .shadow(radius: 10)
                            .font(.subheadline)
                            .onAppear {
                                DispatchQueue.main.asyncAfter(
                                    deadline: .now() + 2
                                ) {
                                    withAnimation {
                                        viewModel.isPopOverPresented = false
                                    }
                                }
                            }
                            .presentationCompactAdaptation((.popover))
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
            .sheet(isPresented: $viewModel.showingNewItemView) {
                NewItemView(newItemPresented: $viewModel.showingNewItemView)
            }
            .sheet(isPresented: $viewModel.showingUpdateItemView) {
                if let item = viewModel.itemToUpdate {
                    UpdateItemView(
                        item: item,
                        updateItemPresented: $viewModel.showingUpdateItemView)
                }
            }
            /*.task {
                context.insert(
                    ToDoListItem(title: "Test 1", dueDate: Date()))
                context.insert(
                    ToDoListItem(title: "Test 2", dueDate: Date()))
            }*/
        }
        .padding(.top, 0)
    }
}

#Preview {
    ToDoListView()
        .modelContainer(for: ToDoListItem.self, inMemory: true)
}
