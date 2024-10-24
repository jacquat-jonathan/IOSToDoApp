//
//  ToDoListViewViewModel.swift
//  TestApp
//
//  Created by Jonathan Jacquat on 14.10.2024.
//

import Foundation
import SwiftData

class ToDoListViewViewModel: ObservableObject {
    @Published var showingNewItemView = false
    @Published var showingUpdateItemView = false
    @Published var itemToUpdate: ToDoListItem?
    @Published var showDeleteAllAlert = false
    @Published var isPopOverPresented = false

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
}
