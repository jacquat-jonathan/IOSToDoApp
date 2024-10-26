//
//  ToDoListItemView.swift
//  TestApp
//
//  Created by Jonathan Jacquat on 14.10.2024.
//

import SwiftData
import SwiftUI

struct ToDoListItemView: View {
    @StateObject private var viewModel = ToDoListItemViewViewModel()
    @Environment(\.modelContext) private var context
    private let notificationBuilder: NotificationBuilder = NotificationBuilder()

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
            Text(item.title)
                .font(.body)

            Spacer()

            Button {
                viewModel.toggleIsDone(item: item)
                if item.isDone {
                    notificationBuilder.sendNotification(
                        title: item.title, body: "Good job! Task done!")
                }
            } label: {
                Image(
                    systemName: item.isDone ? "checkmark.circle.fill" : "circle"
                )
                .foregroundStyle(.blue)
            }
            .disabled(disabled)
        }
        .padding(.vertical, 10)
    }
}

#Preview {
    ToDoListItemView(
        item: .init(title: "Default", dueDate: Date(), priority: 2),
        disabled: false)
}
