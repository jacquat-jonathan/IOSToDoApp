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
    
    static func from(int: Int) -> Priority? {
        return Priority(rawValue: int)
    }
}

enum RecursivityEnum: Int, Identifiable, CaseIterable {
    case none = 0, daily, weekly, monthly, yearly //, monday, tuesday, wednesday, thursday, friday, saturday, sunday
    var id: Int { self.rawValue }
    
    var name: String {
        switch self {
        case .none: "None"
        case .daily: "Daily"
        case .weekly: "Weekly"
        case .monthly: "Monthly"
        case .yearly: "Yearly"
        /*
        case .monday: "Each monday"
        case .tuesday: "Each tuesday"
        case .wednesday: "Each wednesday"
        case .thursday: "Each thursday"
        case .friday: "Each friday"
        case .saturday: "Each saturday"
        case .sunday: "Each sunday"
         */
        }
    }
    
    static func from(int: Int) -> RecursivityEnum? {
        return RecursivityEnum(rawValue: int)
    }
}

@Model
class Recursivity: Identifiable {
    var type: Int
    var repeats: Int
    
    init(type: Int, repeats: Int) {
        self.type = type
        self.repeats = repeats
    }
    
    init() {
        self.type = RecursivityEnum.none.rawValue
        self.repeats = 0
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
    var recursivity: Recursivity
    // var reminder: Bool

    init(title: String, dueDate: Date, priority: Int, recursivity: Recursivity? = nil) {
        self.title = title
        self.dueDate = Calendar.current.startOfDay(for: dueDate)
        self.isDone = false
        self.isArchived = false
        self.priority = priority
        self.recursivity = recursivity != nil ? recursivity! : Recursivity()
    }
    
    init() {
        self.title = ""
        self.dueDate = Calendar.current.startOfDay(for: .now)
        self.isDone = false
        self.isArchived = false
        self.priority = Priority.medium.rawValue
        self.recursivity = Recursivity()
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
