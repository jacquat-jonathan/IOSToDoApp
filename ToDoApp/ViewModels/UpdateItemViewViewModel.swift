//
//  UpdateItemViewViewModel.swift
//  TestApp
//
//  Created by Jonathan Jacquat on 18.10.2024.
//

import Foundation
import SwiftData

class UpdateItemViewViewModel: ObservableObject {
    @Published var showAlert = false
    @Published var itemToUpdate: ToDoListItem
        
    init(item: ToDoListItem) {
        self.itemToUpdate = item
    }
    
    func update(context: ModelContext) {
        guard canSave else {
            return
        }
        try? context.save()
    }
    
    func loadCurrentItem() {
        
    }
    
    var canSave: Bool {
        guard !itemToUpdate.title.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        guard itemToUpdate.dueDate >= Date().addingTimeInterval(-86400) else {
            return false
        }
        return true
    }
}
