//
//  NotificationesExampleView.swift
//  NotificationesExampleView
//
//  Created by Alessandro Pace on 31/7/21.
//

import UserNotifications
import SwiftUI

struct NotificationesExampleView: View {
    var body: some View {
        
        VStack {
            Button("Request Permissions") {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        print("All set!")
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }
            .padding()
            
            Button("Schedule Notification") {
                let content = UNMutableNotificationContent()
                content.title = "Feed the cat"
                content.subtitle = "It looks hungry"
                content.sound = UNNotificationSound.default

                // show this notification five seconds from now
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

                // choose a random identifier
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                // add our notification request
                UNUserNotificationCenter.current().add(request)
            }
            .padding()
            
        }
    }
}

struct NotificationesExampleView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationesExampleView()
    }
}
