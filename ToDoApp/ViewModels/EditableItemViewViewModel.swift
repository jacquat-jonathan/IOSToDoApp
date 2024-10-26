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
        guard canSave else {
            return
        }
        if !isUpdating {
            if item.recursivity.type != RecursivityEnum.none.rawValue {
                let calendar = Calendar.current
                switch RecursivityEnum.from(int: item.recursivity.type) {
                case .daily:
                    for rep in 0...item.recursivity.repeats {
                        let newDate = calendar.date(byAdding: .day, value: rep, to: item.dueDate)
                        context.insert(ToDoListItem(title: item.title, dueDate: newDate!, priority: item.priority, recursivity: item.recursivity))
                    }
                case .weekly:
                    for rep in 0...item.recursivity.repeats {
                        let newDate = calendar.date(byAdding: .day, value: rep * 7, to: item.dueDate)
                        context.insert(ToDoListItem(title: item.title, dueDate: newDate!, priority: item.priority, recursivity: item.recursivity))
                    }
                case .monthly:
                    for rep in 0...item.recursivity.repeats {
                        let newDate = calendar.date(byAdding: .month, value: rep, to: item.dueDate)
                        context.insert(ToDoListItem(title: item.title, dueDate: newDate!, priority: item.priority, recursivity: item.recursivity))
                    }
                case .yearly:
                    for rep in 0...item.recursivity.repeats {
                        let newDate = calendar.date(byAdding: .year, value: rep, to: item.dueDate)
                        context.insert(ToDoListItem(title: item.title, dueDate: newDate!, priority: item.priority, recursivity: item.recursivity))
                    }
                case nil, .some(.none):
                    context.insert(item)
                }
            }
            try? context.save()
        }
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
