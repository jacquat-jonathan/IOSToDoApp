//
//  ToDoListViewViewModel.swift
//  TestApp
//
//  Created by Jonathan Jacquat on 14.10.2024.
//

import Foundation
import SwiftData

struct DailyItems: Identifiable {
    var id = UUID()
    var items: [ToDoListItem]
    var date: String
}

class ToDoListViewViewModel: ObservableObject {
    @Published var showingNewItemView = false
    @Published var showingUpdateItemView = false
    @Published var itemToUpdate: ToDoListItem?
    @Published var showDeleteAllAlert = false
    @Published var showRestoreAllAlert = false
    @Published var isPopOverPresented = false
    @Published var showMoveOverdueAlert = false

    init() {}

    func delete(context: ModelContext, item: ToDoListItem) {
        context.delete(item)
        try? context.save()
    }

    func deleteAll(context: ModelContext, list: [ToDoListItem]) {
        for item in list {
            context.delete(item)
        }
        try? context.save()
    }
    
    func restoreAll(context: ModelContext, list: [ToDoListItem]) {
        for item in list {
            setArchive(context: context, item: item)
        }
    }

    func setArchive(context: ModelContext, item: ToDoListItem) {
        item.setIsArchived(!item.isArchived)
        try? context.save()
    }

    func getItemsByDate(_ toDoListItems: [ToDoListItem]) -> [DailyItems] {
        var dailyItems: [DailyItems] = []
        let items = toDoListItems.sorted(by: { $0.dueDate < $1.dueDate })
        for item in items {
            let index = dailyItems.firstIndex(where: {
                $0.date == formatDate(item.dueDate)
            })
            if index != nil {
                dailyItems[index!].items.append(item)
                dailyItems[index!].items.sort(by: {
                    if $0.isDone == $1.isDone {
                        if $0.priority == $1.priority {
                            return $0.title < $1.title
                        } else {
                            return $0.priority > $1.priority
                        }
                    }
                    return !$0.isDone
                })
            } else {
                dailyItems.append(
                    DailyItems(items: [item], date: formatDate(item.dueDate)))
            }
        }
        return dailyItems
    }

    func formatDate(_ date: Date) -> String {
        return date.formatted(.dateTime.year().month(.wide).day(.twoDigits))
    }
    
    func movePassedTasks(context: ModelContext, list: [ToDoListItem]) {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: .now)
        let overdueItems = list.filter { calendar.startOfDay(for: $0.dueDate) < today }
        for item in overdueItems {
            item.dueDate = today
        }
        try? context.save()
    }
}
