//
//  BookWormApp.swift
//  BookWorm
//
//  Created by Alessandro Pace on 2/6/21.
//

import SwiftUI

@main
struct BookWormApp: App {
    
    let persistenceController = PersistenceController.shared
        
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
