//
//  NotificationBuilder.swift
//  ToDoApp
//
//  Created by Jonathan Jacquat on 25.10.2024.
//

import Foundation
import UserNotifications


class NotificationBuilder {
    
    func sendNotification(title: String, body: String?, timeInterval: TimeInterval? = 10) {
        let content = UNMutableNotificationContent()
        content.title = title
        if let body = body {
            content.body = body
        }
        content.sound = .default
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval!, repeats: false)
        let request = UNNotificationRequest(identifier: "localNotification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("erreur lers de l'ajout de la notification : \(error.localizedDescription)")
            }
        }
    }
}
