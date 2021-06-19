//
//  UsersListApp.swift
//  UsersList
//
//  Created by Alessandro Pace on 17/6/21.
//

import SwiftUI

@main
struct UsersListApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
