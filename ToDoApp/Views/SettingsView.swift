//
//  SettingsView.swift
//  TestApp
//
//  Created by Jonathan Jacquat on 18.10.2024.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("isNotificationEnabled") private var isNotificationEnabled =
        false
    @AppStorage("isAutomaticArchive") private var isAutomaticArchive = true

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List {
                    Section("Notification") {
                        Toggle(
                            "Enable notification", isOn: $isNotificationEnabled)
                    }
                    
                    Section("Automation") {
                        Toggle(isOn: $isAutomaticArchive) {
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Automatic archiving")
                                Text(
                                    "Automatically archive tasks once the date has passed"
                                )
                                .font(.system(size: 12, weight: .thin))
                            }
                        }
                    }

                    Section("App appearance") {
                        Toggle(isOn: $isDarkMode) {
                            HStack(spacing: 6) {
                                Image(systemName: isDarkMode ? "moon.fill" : "sun.max")
                                Text(isDarkMode ? "Dark mode" : "Light mode")
                            }
                        }
                    }
                    Text("Version 0.1")
                }
                .listStyle(.automatic)
                .background(.white)
            }
            .navigationTitle("Settings")
            .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}

#Preview {
    SettingsView().modelContainer(for: ToDoListItem.self, inMemory: true)
}
