//
//  TestAppApp.swift
//  TestApp
//
//  Created by Jonathan Jacquat on 14.10.2024.
//

import SwiftUI

@main
struct TestAppApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            MainView()
                .modelContainer(for: ToDoListItem.self, inMemory: true)
        }
    }
}
