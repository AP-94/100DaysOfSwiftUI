//
//  ProspectView.swift
//  ProspectView
//
//  Created by Alessandro Pace on 31/7/21.
//

import UserNotifications
import SwiftUI

struct ProspectView: View {
    
    @EnvironmentObject var prospects: Prospects
    let prospect: Prospect
    let filter: ProspectsFilterType
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(prospect.name)
                    .font(.headline)
                Text(prospect.emailAddress)
                    .foregroundColor(.secondary)
            }
            Spacer()
            
            //CHALLENGE 1: ADD IMAGE TO KNOW IS PROSPECT IS CONTACTED
            if filter == .none {
                Image(systemName: "mail.fill")
                    .foregroundColor(prospect.isContacted ? .green : .red)
                    .padding()
            }
        }
        .contextMenu {
            Button(prospect.isContacted ? "Mark Uncontacted" : "Mark Contacted") {
                prospects.toogle(prospect)
            }
            
            if !prospect.isContacted {
                Button("Remind me") {
                    addNotification(for: prospect)
                }
            }
        }
    }
    
    private func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default
            
            //            var dateComponents = DateComponents()
            //            dateComponents.hour = 9
            //            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            
            center.add(request)
        }
        
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else {
                        print("Doh")
                    }
                }
            }
        }
    }
}

struct ProspectView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectView(prospect: Prospect(), filter: .none)
    }
}
