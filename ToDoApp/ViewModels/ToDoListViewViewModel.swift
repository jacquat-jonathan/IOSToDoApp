//
//  ToDoListViewViewModel.swift
//  TestApp
//
//  Created by Jonathan Jacquat on 14.10.2024.
//

import Foundation
import SwiftData

enum SortOption {
    case dueDate, title
}

class ToDoListViewViewModel: ObservableObject {
    @Published var showingNewItemView = false
    @Published var showingUpdateItemView = false
    @Published var itemToUpdate: ToDoListItem?
    @Published var showDeleteAllAlert = false
    @Published var order = 0
    @Published var isPopOverPresented = false
    
    
    @Published var sortOption: SortOption = .dueDate
    @Published var sortOrder: SortOrder = .forward

    
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
    
    func setArchive(context: ModelContext, item: ToDoListItem) {
        item.setIsArchived(!item.isArchived)
        try? context.save()
    }
    
    func switchOrder() {
        order += 1
        switch order {
        case 1:
            sortOption = .dueDate
            sortOrder = .reverse
        case 2:
            sortOption = .title
            sortOrder = .forward
        default:
            order = 0
            sortOption = .dueDate
            sortOrder = .forward
        }
    }
}
