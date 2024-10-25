//
//  ToDoListItemView.swift
//  TestApp
//
//  Created by Jonathan Jacquat on 14.10.2024.
//

import SwiftUI
import SwiftData

struct ToDoListItemView: View {
    @StateObject private var viewModel = ToDoListItemViewViewModel()
    @Environment(\.modelContext) private var context

    let item: ToDoListItem
    var disabled: Bool = false
    
    func getColor() -> Color {
        switch Priority.from(int: item.priority)! {
        case .low:
            return Color.blue
        case .medium:
            return Color.green
        case .high:
            return Color.yellow
        case .urgent:
            return Color.red
        }
    }
    
    var body: some View {
        HStack {
            Image(systemName: "tag.fill")
                .foregroundStyle(getColor())
                .padding(.trailing)
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.body)
            }
            
            Spacer()
            
            Button {
                viewModel.toggleIsDone(item: item)
            } label: {
                Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
                    .foregroundStyle(.blue)
            }
            .disabled(disabled)
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
    }
}

#Preview {
    ToDoListItemView(item: .init(title: "Default", dueDate: Date(), priority: 2), disabled: false)
}
