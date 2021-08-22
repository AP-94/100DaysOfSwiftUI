//
//  DiceRollerApp.swift
//  DiceRoller
//
//  Created by Alessandro Pace on 12/8/21.
//

import SwiftUI

@main
struct DiceRollerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            TabsView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
