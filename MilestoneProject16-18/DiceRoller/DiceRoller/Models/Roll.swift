//
//  Dice.swift
//  Dice
//
//  Created by Alessandro Pace on 12/8/21.
//

import Foundation

struct Roll {
    var id = UUID()
    var numberOfDices: Int
    var diceSides: Int
    var result: Int
    
    static let example = Roll(id: UUID(), numberOfDices: 3, diceSides: 6, result: 123)
}
