//
//  AppDelegate.swift
//  ToDoApp
//
//  Created by Jonathan Jacquat on 25.10.2024.
//

import UIKit
import UserNotifications

class AppDelegate: NSObject, UIApplicationDelegate,
    UNUserNotificationCenterDelegate
{
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication
            .LaunchOptionsKey: Any]?
    ) -> Bool {
        let userDefaults = UserDefaults.standard
        let hasRequestedAuthorization = userDefaults.bool(
            forKey: "hasRequestedNotificationAuthorization")

        if !hasRequestedAuthorization {
            UNUserNotificationCenter.current().requestAuthorization(options: [
                .alert, .sound, .badge,
            ]) { granted, error in
                if let error = error {
                    print(
                        "Erreur lors de la demande de la permission : \(error.localizedDescription)"
                    )
                } else {
                    userDefaults.set(
                        true, forKey: "hasRequestedNotificationAuthorization")
                    userDefaults.synchronize()
                    if granted {
                        print("Permission granted")
                    } else {
                        print("Permission denied")
                    }
                }
            }
        }
        UNUserNotificationCenter.current().delegate = self
        return true
    }

    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (
            UNNotificationPresentationOptions
        ) -> Void
    ) {
        completionHandler([.banner, .sound])
    }
}
