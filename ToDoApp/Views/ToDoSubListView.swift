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
    @StateObject private var viewModel = ToDoListViewViewModel()
    @Environment(\.modelContext) private var context

    let items: [ToDoListItem]
    let date: String
    var show: Bool = true


    var body: some View {
        if show {
            NavigationView {
                VStack(alignment: .leading) {
                    Text(date)
                        .font(.title2)
                        .padding(.horizontal)
                    
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
                    .listStyle(InsetGroupedListStyle())
                }
            }
        }
    }
}

#Preview {
    ToDoSubListView(items: [ToDoListItem(title: "Test", dueDate: .now)], date: "22.01.1999")
        .modelContainer(for: ToDoListItem.self, inMemory: true)
}