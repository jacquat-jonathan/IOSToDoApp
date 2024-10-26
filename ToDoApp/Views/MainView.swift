//
//  MainView.swift
//  TestApp
//
//  Created by Jonathan Jacquat on 14.10.2024.
//

import SwiftData
import SwiftUI

struct MainView: View {

    @Environment(\.modelContext) private var context

    @AppStorage("isDarkMode") private var isDarkMode = false

    var body: some View {
        NavigationView {
            TabView {
                ToDoListView()
                    .modelContainer(for: ToDoListItem.self)
                    .tabItem {
                        Label("Tasks", systemImage: "pencil.and.list.clipboard")
                    }
                CalendarView()
                    .modelContainer(for: ToDoListItem.self)
                    .tabItem {
                        Label("Calendar", systemImage: "calendar")
                    }
                ArchiveView()
                    .modelContainer(for: ToDoListItem.self)
                    .tabItem {
                        Label("Archive", systemImage: "archivebox")
                    }
                SettingsView()
                    .modelContainer(for: ToDoListItem.self)
                    .tabItem {
                        Label("Settings", systemImage: "gear")
                    }
            }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

#Preview {
    MainView()
}
