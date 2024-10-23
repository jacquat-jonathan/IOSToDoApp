//
//  ToDoListItem.swift
//  TestApp
//
//  Created by Jonathan Jacquat on 14.10.2024.
//

import Foundation
import SwiftData

@Model
class ToDoListItem: Identifiable, ObservableObject {
    var title: String
    var dueDate: Date
    var isDone: Bool
    // var category: Category
    var isArchived: Bool

    init(title: String, dueDate: Date) {
        self.title = title
        self.dueDate = dueDate
        self.isDone = false
        self.isArchived = false
    }
    
    init() {
        self.title = ""
        self.dueDate = Date()
        self.isDone = false
        self.isArchived = false
    }
    
    func setDone(_ state: Bool) {
        self.isDone = state
    }
    
    func setIsArchived(_ state: Bool) {
        self.isArchived = state
    }
}
