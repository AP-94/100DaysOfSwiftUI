//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by Alessandro Pace on 14/6/21.
//

import SwiftUI

@main
struct CoreDataProjectApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ChallengeView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
