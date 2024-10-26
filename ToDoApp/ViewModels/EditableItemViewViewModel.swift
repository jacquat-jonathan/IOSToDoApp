//
//  EditableItemViewViewModel.swift
//  ToDoApp
//
//  Created by Jonathan Jacquat on 26.10.2024.
//

import Foundation
import SwiftData

class EditableItemViewViewModel: ObservableObject {
    @Published var showAlert = false
    @Published var isUpdating: Bool = false
    @Published var item: ToDoListItem = ToDoListItem()

    init() {}
    
    init(item: ToDoListItem) {
        self.item = item
        self.isUpdating = true
    }

    func save(context: ModelContext) {
        print(item.title)
        print(item.dueDate)
        guard canSave else {
            return
        }
        if !isUpdating {
            print("create")
            context.insert(item)
        }
        try? context.save()
    }

    var canSave: Bool {
        guard !item.title.trimmingCharacters(in: .whitespaces).isEmpty
        else {
            return false
        }
        guard item.dueDate >= Date().addingTimeInterval(-86400) else {
            return false
        }
        return true
    }
}
