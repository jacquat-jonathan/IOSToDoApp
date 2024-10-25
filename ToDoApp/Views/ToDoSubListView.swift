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

struct ToDoSubListView: View {
    @StateObject var viewModel: ToDoListViewViewModel
    @Environment(\.modelContext) private var context

    let items: [ToDoListItem]
    let date: String
    var show: Bool = true

    var body: some View {
        ForEach(items) { item in
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

#Preview {
    ToDoSubListView(
        viewModel: ToDoListViewViewModel(),
        items: [ToDoListItem(title: "Test 1", dueDate: .now, priority: 2), ToDoListItem(title: "Test 2", dueDate: .now, priority: 3), ToDoListItem(title: "Test 3", dueDate: .now, priority: 4)],
        date: "22.01.1999"
    )
    .modelContainer(for: ToDoListItem.self, inMemory: true)
}
