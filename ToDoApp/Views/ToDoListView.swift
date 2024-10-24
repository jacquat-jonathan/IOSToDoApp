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

struct DailyItems: Identifiable {
    var id = UUID()
    var items: [ToDoListItem]
    var date: String
}

struct ToDoListView: View {
    @StateObject private var viewModel = ToDoListViewViewModel()
    @Environment(\.modelContext) private var context

    // Liste des items non archivés
    @Query(
        filter: #Predicate<ToDoListItem> { item in
            !item.isArchived
        }, sort: \ToDoListItem.dueDate) private var toDoListItems:
        [ToDoListItem]

    func getItemsByDate() -> [DailyItems] {
        var dailyItems: [DailyItems] = []
        let items = toDoListItems.sorted(by: { $0.dueDate < $1.dueDate })
        for item in items {
            let index = dailyItems.firstIndex(where: {$0.date == formatDate(item.dueDate)})
            if index != nil {
                dailyItems[index!].items.append(item)
                dailyItems[index!].items.sort(by: { !$0.isDone && $1.isDone})
            } else {
                dailyItems.append(
                    DailyItems(items: [item], date: formatDate(item.dueDate)))
            }
        }
        return dailyItems
    }

    func formatDate(_ date: Date) -> String {
        return date.formatted(.dateTime.day(.twoDigits).month(.twoDigits))
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(getItemsByDate()) { daily in
                        ToDoSubListView(items: daily.items, date: daily.date)
                    }
                }
                .navigationTitle("To Do List")
                .toolbar {
                    ToolbarItemGroup(
                        placement: .topBarTrailing,
                        content: { ToolbarView(toDoListItems: toDoListItems) })
                }
                .sheet(isPresented: $viewModel.showingNewItemView) {
                    NewItemView(newItemPresented: $viewModel.showingNewItemView)
                }
                .sheet(isPresented: $viewModel.showingUpdateItemView) {
                    if let item = viewModel.itemToUpdate {
                        UpdateItemView(
                            item: item,
                            updateItemPresented: $viewModel
                                .showingUpdateItemView)
                    }
                }
            }
        }
        .padding(.top, 0)
    }
}

#Preview {
    ToDoListView()
        .modelContainer(for: ToDoListItem.self, inMemory: true)
}
