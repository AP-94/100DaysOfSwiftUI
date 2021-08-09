//
//  NotifyCenterView.swift
//  NotifyCenterView
//
//  Created by Alessandro Pace on 3/8/21.
//

import SwiftUI

struct NotifyCenterView: View {
    
    var body: some View {
        
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                    print("Moving to background")
                }
            
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                    print("Moving to foreground")
                }
            
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.userDidTakeScreenshotNotification)) { _ in
                    print("User took a screenshoot!!!!")
                }
        }
        
    }
}

struct NotifyCenterView_Previews: PreviewProvider {
    static var previews: some View {
        NotifyCenterView()
    }
}
