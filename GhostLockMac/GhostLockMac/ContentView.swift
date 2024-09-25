//
//  ContentView.swift
//  GhostLockMac
//
//  Created by Mahdi Heydar on 2024-09-24.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    
    // MacBook state monitoring
    @State private var isLidClosed = false
    @State private var isSwipeDetected = false
    @State private var isKeyPressed = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("GhostLock is Monitoring Your Mac")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            if isLidClosed {
                Text("Warning: Lid Closed")
                    .foregroundColor(.red)
                    .font(.title2)
            }
            
            if isSwipeDetected {
                Text("Warning: Swipe Detected")
                    .foregroundColor(.orange)
                    .font(.title2)
            }
            
            if isKeyPressed {
                Text("Warning: Key Press Detected")
                    .foregroundColor(.blue)
                    .font(.title2)
            }
            
            // Test alarm button (you can trigger an action here)
            Button(action: {
                triggerAlarmNotification()
            }) {
                Text("Trigger Test Alarm")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(10)
            }
        }
        .padding()
        .onAppear {
            // Placeholder for the logic to start monitoring the events
            startMonitoring()
        }
    }
    
    // Function to start monitoring the lid, swipe, and key press events
    func startMonitoring() {
        // Implement actual macOS event handling for lid closure, swipe, and key press
        // Here you could call macOS APIs or use custom event listeners

        // Example dummy monitoring (replace with actual logic)
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.isLidClosed = true // Simulating lid closure after 5 seconds
            sendNotification(type: "Lid Closed")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
            self.isSwipeDetected = true // Simulating swipe detection after 8 seconds
            sendNotification(type: "Swipe Detected")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 12) {
            self.isKeyPressed = true // Simulating key press detection after 12 seconds
            sendNotification(type: "Key Press Detected")
        }
    }
    
    // Function to send a notification to the iPhone based on the event type
    func sendNotification(type: String) {
        let content = UNMutableNotificationContent()
        content.title = "GhostLock Alert"
        content.body = "\(type) detected on your Mac!"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    // Test function to trigger the alarm (you can customize this for your alarm logic)
    func triggerAlarmNotification() {
        let content = UNMutableNotificationContent()
        content.title = "GhostLock Alarm"
        content.body = "Test alarm has been triggered on your Mac!"
        content.sound = UNNotificationSound.defaultCritical
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
