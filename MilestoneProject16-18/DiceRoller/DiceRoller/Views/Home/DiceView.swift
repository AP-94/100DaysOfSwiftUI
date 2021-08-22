//
//  DiceView.swift
//  DiceView
//
//  Created by Alessandro Pace on 13/8/21.
//

import SwiftUI

struct DiceView: View {
    
    let dice: Dice
    let dicePosition: Int
    let backgroundColors: [Color] = [.blue, .green, .red, .orange, .yellow]
    
    var body: some View {
        VStack {
            Text("\(dice.number)")
                .font(dice.number == 100 ? .title2 : .title)
                .fontWeight(.heavy)
                .foregroundColor(Color.white)
                .frame(width: 45, height: 45)
                .padding(10)
//            Text("Dice n° \(dicePosition)")
//                .font(.caption)
//                .fontWeight(.bold)
//                .padding([.leading, .trailing, .bottom])
        }
        .background(backgroundColors.randomElement())
        .clipShape(Circle())
        .shadow(radius: 3)
//        .padding()
        
    }
}

struct DiceView_Previews: PreviewProvider {
    static var previews: some View {
        DiceView(dice: Dice.example, dicePosition: 1)
    }
}
