//
//  GhostLockMacApp.swift
//  GhostLockMac
//
//  Created by Mahdi Heydar on 2024-09-24.
//

import SwiftUI
import UserNotifications

@main
struct GhostLockMacApp: App {

    @Environment(\.scenePhase) var scenePhase

    // Strong reference to the delegate
    let notificationDelegate = NotificationDelegate()

    init() {
        // Set the notification delegate
        UNUserNotificationCenter.current().delegate = notificationDelegate
        // Request notification permission
        requestNotificationPermission()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()  // Reference to ContentView
        }
        .onChange(of: scenePhase) { newPhase in
            // Handle app lifecycle events here if necessary
        }
    }

    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
            if granted {
                print("Notification permission granted.")
            } else {
                print("Notification permission denied.")
            }
        }
    }
}

class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.actionIdentifier == UNNotificationDefaultActionIdentifier {
            print("Notification clicked or tapped.")
        }
        completionHandler()
    }
}

