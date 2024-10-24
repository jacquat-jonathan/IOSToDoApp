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
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.body)
                Text("\(item.dueDate.formatted(date: .numeric, time: .omitted))")
                    .font(.footnote)
                    .foregroundStyle(Color(.secondaryLabel))
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
        .padding()
    }
}

#Preview {
    ToDoListItemView(item: .init(title: "Default", dueDate: Date(), priority: 2), disabled: false)
}
