//
//  ContentView.swift
//  MultiplicationTables
//
//  Created by Alessandro Pace on 10/3/21.
//

import SwiftUI

class SettingsToggle: ObservableObject {
    @Published var gameStarted = false
}

struct ContentView: View {
    
    @ObservedObject var settingsToggle = SettingsToggle()
    @ObservedObject var gameData = GameData()
    
    var body: some View {
        NavigationView {
            ZStack {
                if settingsToggle.gameStarted  {
                    GameView(settingsToggle: settingsToggle, gameData: gameData)
                } else {
                    SettingsView(settingsToggle: settingsToggle, gameData: gameData)
                }
            }
            .navigationTitle(settingsToggle.gameStarted ? "Multiplication Game" : "Settings")
            .navigationBarItems(leading:
                                    Button(action: goToSettings) {
                                        if settingsToggle.gameStarted {
                                            Text("New Game")
                                        }
                                    }.statusBar(hidden: settingsToggle.gameStarted ? true : true)
            )
        }
    }
    
    func goToSettings() {
        settingsToggle.gameStarted = false
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
