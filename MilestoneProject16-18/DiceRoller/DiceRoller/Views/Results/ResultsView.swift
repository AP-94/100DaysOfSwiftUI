//
//  ResultsView.swift
//  ResultsView
//
//  Created by Alessandro Pace on 12/8/21.
//

import SwiftUI

struct ResultsView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: DiceRoll.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \DiceRoll.date, ascending: true)
    ]) var diceRollResults: FetchedResults<DiceRoll>
    
    var body: some View {
        NavigationView {
            List(diceRollResults, id: \.self) { diceResult in
                DiceRollResultView(roll: diceResult)
            }
            .navigationTitle("Results")
        }
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView()
    }
}
