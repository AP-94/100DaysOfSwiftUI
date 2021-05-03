//
//  SettingsView.swift
//  MultiplicationTables
//
//  Created by Alessandro Pace on 26/4/21.
//

import SwiftUI

struct SettingsView: View {
    
    @ObservedObject var settingsToggle: SettingsToggle
    @ObservedObject var gameData: GameData
    
    var questionAmounts = ["5", "10", "20", "All"]
    
    
    var body: some View {
        Group {
            VStack {
                Form {
                    Section(header: Text("Select until which table you want to practice").font(.subheadline)) {
                        Stepper(value: $gameData.numberOfTables, in: 1...12) {
                            Text("\(gameData.numberOfTables)")
                        }
                    }
                    
                    Section(header: Text("Number of questions").font(.subheadline)) {
                        Picker(selection: $gameData.selectedNumberOfQuestionsIndex, label: Text("How many questions?")) {
                            ForEach(0..<self.questionAmounts.count) {
                                index in
                                Text("\(self.questionAmounts[index])")
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    
                    Button(action: startGame) {
                        Text("Start Game")
                    }.font(.system(size: 40))
                    .colorInvert()
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                    }
            }
        }
    }
    
    func startGame() {
        settingsToggle.gameStarted = true
        gameData.generateAllQuestions(tables: gameData.numberOfTables, numberOfQuestions: gameData.numberOfQuestions)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(settingsToggle: SettingsToggle(), gameData: GameData())
    }
}
