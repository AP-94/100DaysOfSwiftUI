//
//  DiceRollResultView.swift
//  DiceRollResultView
//
//  Created by Alessandro Pace on 12/8/21.
//

import SwiftUI

struct DiceRollResultView: View {
    
    let roll: DiceRoll
    
    var body: some View {
        ZStack {
            HStack(alignment: .center) {
                Image(systemName: "dice.fill")
                    .padding(.leading)
                
                Text("\(roll.numberOfDices)")
                    .font(.headline)
                
                Spacer()
                
                VStack(alignment: .center) {
                    Text("\(roll.sides)")
                        .font(.headline)
                    Text("Sides")
                        .font(.caption)
                        .fontWeight(.bold)
                }
                
                Spacer()
                
                VStack(alignment: .center) {
                    Text("Total")
                        .font(.caption)
                        .fontWeight(.heavy)
                    Text("\(roll.result)")
                        .font(.title)
                        .foregroundColor(.green)
                }
                .frame(width: 55)
                .padding(.trailing)
                
            }
            .frame(maxWidth: .infinity, maxHeight: 55)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 1)
            )
            .padding()
        }
        .background(Color.white)
    }
    
}

//struct DiceRollResultView_Previews: PreviewProvider {
//    static var previews: some View {
//        DiceRollResultView()
//    }
//}

