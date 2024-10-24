//
//  ToDoListItem.swift
//  TestApp
//
//  Created by Jonathan Jacquat on 14.10.2024.
//

import Foundation
import SwiftData

enum Priority: Int, CaseIterable, Identifiable {
    case low = 1, medium, high, urgent
    
    var id: Int { self.rawValue }
    
    var name: String {
        switch self {
        case .low: return "Low"
        case .medium: return "Medium"
        case .high: return "High"
        case .urgent: return "Urgent"
        }
    }
}


@Model
class ToDoListItem: Identifiable, ObservableObject {
    var title: String
    var dueDate: Date
    var isDone: Bool
    var isArchived: Bool
    var category: Category?
    var priority: Int

    init(title: String, dueDate: Date, priority: Int) {
        self.title = title
        self.dueDate = dueDate
        self.isDone = false
        self.isArchived = false
        self.priority = priority
    }
    
    init() {
        self.title = ""
        self.dueDate = Date()
        self.isDone = false
        self.isArchived = false
        self.priority = Priority.medium.rawValue
    }
    
    func setDone(_ state: Bool) {
        self.isDone = state
    }
    
    func setIsArchived(_ state: Bool) {
        self.isArchived = state
    }
    
    func setCategory(_ category: Category) {
        self.category = category
    }
}
