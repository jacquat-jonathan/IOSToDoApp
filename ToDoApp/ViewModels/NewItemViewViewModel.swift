//
//  NewItemViewViewModel.swift
//  TestApp
//
//  Created by Jonathan Jacquat on 14.10.2024.
//

import Foundation
import SwiftData

class NewItemViewViewModel: ObservableObject {
    @Published var title = ""
    @Published var dueDate = Date()
    @Published var priority = Priority.medium
    @Published var showAlert = false
        
    init() {}
    
    func save(context: ModelContext) {
        context.insert(ToDoListItem(title: title, dueDate: dueDate, priority: priority.rawValue))
        try? context.save()
    }
    
    func update(context: ModelContext) {
        guard canSave else {
            return
        }
        try? context.save()
    }
    
    var canSave: Bool {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        guard dueDate >= Date().addingTimeInterval(-86400) else {
            return false
        }
        return true
    }
}
