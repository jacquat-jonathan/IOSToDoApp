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
    @AppStorage("isNotificationEnabled") private var isNotificationEnabled =
        true
    private let nbuilder: NotificationBuilder = NotificationBuilder()

    // Liste des items non archivés
    @Query(
        filter: #Predicate<ToDoListItem> { item in
            !item.isArchived
        }, sort: \ToDoListItem.dueDate) private var toDoListItems:
        [ToDoListItem]

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List(viewModel.getItemsByDate(toDoListItems)) { daily in
                    Section(daily.date) {
                        ForEach(daily.items) { item in
                            ToDoListItemView(item: item)
                                .swipeActions {
                                    Button(
                                        "Delete",
                                        action: {
                                            viewModel.delete(
                                                context: context, item: item)
                                        }
                                    )
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
                    }
                }

            }
            .navigationTitle("Tasks")
            .toolbar {
                ToolbarItemGroup(
                    placement: .topBarTrailing,
                    content: {
                        ToolbarView(
                            viewModel: viewModel,
                            toDoListItems: toDoListItems)
                    })
            }
            .sheet(isPresented: $viewModel.showingNewItemView) {
                EditableItemView(
                    viewModel: EditableItemViewViewModel(),
                    itemPresented: $viewModel.showingNewItemView)
            }
            .sheet(isPresented: $viewModel.showingUpdateItemView) {
                if viewModel.itemToUpdate != nil {
                    EditableItemView(
                        viewModel: EditableItemViewViewModel(
                            item: viewModel.itemToUpdate!),
                        itemPresented: $viewModel.showingUpdateItemView)
                }
            }
            .task({
                /*
                context.insert(
                    ToDoListItem(
                        title: "Test 1", dueDate: .now, priority: 4))
                context.insert(
                    ToDoListItem(
                        title: "Test 2",
                        dueDate: .now.addingTimeInterval(24 * 60 * 60),
                        priority: 2))
                context.insert(
                    ToDoListItem(
                        title: "Test 3", dueDate: .now, priority: 3))
                context.insert(
                    ToDoListItem(
                        title: "Test 4",
                        dueDate: .now.addingTimeInterval(-2 * 24 * 60 * 60),
                        priority: 2))
                context.insert(
                    ToDoListItem(
                        title: "Test 5",
                        dueDate: .now.addingTimeInterval(-1 * 24 * 60 * 60),
                        priority: 2))

                if isNotificationEnabled {
                    if toDoListItems.count > 0 && toDoListItems.sorted(by: { $0.dueDate < $1.dueDate }).first!.dueDate <= .now.addingTimeInterval(60*60*24) {
                        nbuilder.sendNotification(title: "Day's not finished yet...", body: "You still have some task to do!")
                    }
                }*/

            })
        }
    }
}

#Preview {
    ToDoListView()
        .modelContainer(for: ToDoListItem.self, inMemory: true)
}
