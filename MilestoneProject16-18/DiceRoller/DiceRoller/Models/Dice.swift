//
//  Dice.swift
//  Dice
//
//  Created by Alessandro Pace on 13/8/21.
//

import Foundation

struct Dice: Hashable {
    var id = UUID()
    var number: Int
    
    static let example = Dice(number: 100)
}
