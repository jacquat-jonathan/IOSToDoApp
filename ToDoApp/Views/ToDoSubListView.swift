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
        if show {
            NavigationView {
                VStack(alignment: .leading, spacing: 1) {
                    Text(date)
                        .font(.title2)
                        .padding(.horizontal)
                        .padding(.bottom, 0)
                    
                    List(items) { item in
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
                    .listStyle(PlainListStyle())
                    .padding(.top, 0)
                    .padding(.bottom, 16)
                }
            }
        }
    }
}

#Preview {
    ToDoSubListView(viewModel: ToDoListViewViewModel(), items: [ToDoListItem(title: "Test", dueDate: .now, priority: 2)], date: "22.01.1999")
        .modelContainer(for: ToDoListItem.self, inMemory: true)
}
