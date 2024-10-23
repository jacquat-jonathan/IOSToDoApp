//
//  SettingsView.swift
//  TestApp
//
//  Created by Jonathan Jacquat on 18.10.2024.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Display mode").font(.title2)
                Toggle(
                    isDarkMode ? "Dark mode" : "Light mode", isOn: $isDarkMode)
                Divider()

                Spacer()
            }
            .navigationTitle("Settings")
            .padding()
            .preferredColorScheme(isDarkMode ? .dark : .light)

        }
    }
}

#Preview {
    SettingsView().modelContainer(for: ToDoListItem.self, inMemory: true)
}
