//
//  QuestionModel.swift
//  MultiplicationTables
//
//  Created by Alessandro Pace on 27/4/21.
//

import Foundation

struct Question {
    var firstNumber: Int
    var secondNumber: Int
    
    var answer: Int {
        return firstNumber * secondNumber
    }
}

struct Questions {
    
    func generateAllQuestions(tables: Int, numberOfQuestions: Int) -> [Question] {
        var questionsResult: [Question] = []
        
        for tableNumber in 1...tables {
            for number in 1...12 {
                questionsResult.append(Question(firstNumber: tableNumber, secondNumber: number))
            }
        }
        
        questionsResult.shuffle()
        return questionsResult.pick(length: numberOfQuestions)
    }
}

extension Array  {

    /// Return a smaller array by picking “evenly distributed” elements.
    ///
    /// - Parameter length: The desired array length
    /// - Returns: An array with `length` elements from `self`

    func pick(length: Int) -> [Element]  {
        precondition(length >= 0, "length must not be negative")
        if length >= count { return self }
        let oldMax = Double(count - 1)
        let newMax = Double(length - 1)
        return (0..<length).map { self[Int((Double($0) * oldMax / newMax).rounded())] }
    }
}
