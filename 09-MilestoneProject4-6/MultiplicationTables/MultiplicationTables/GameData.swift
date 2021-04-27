//
//  GameData.swift
//  MultiplicationTables
//
//  Created by Alessandro Pace on 27/4/21.
//

import Foundation

class GameData: ObservableObject {
    @Published var numberOfTables = 1
    @Published var selectedNumberOfQuestionsIndex = 0
    @Published var allQuestions: [Question] = []
    
    var numberOfQuestions: Int {
        switch selectedNumberOfQuestionsIndex {
        case 0:
            return 5
        case 1:
            return 10
        case 2:
            return 20
        default:
            return numberOfAllQuestions()
        }
    }
    
    func numberOfAllQuestions() -> Int {
        return numberOfTables * 12
    }
    
    func generateAllQuestions(tables: Int, numberOfQuestions: Int) {
        allQuestions.removeAll()
        
        for tableNumber in 1...tables {
            for number in 1...12 {
                allQuestions.append(Question(firstNumber: tableNumber, secondNumber: number))
            }
        }
        
        allQuestions.shuffle()
        allQuestions = allQuestions.pick(length: numberOfQuestions)
    }
}
