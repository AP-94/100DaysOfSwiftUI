//
//  OnDeleteView.swift
//  iExpense
//
//  Created by Alessandro Pace on 29/4/21.
//

import SwiftUI

struct OnDeleteView: View {
    
    @State private var numbers: [Int] = []
    @State private var currentNumber = 1
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ///Only puting the numbers in the list would work, but only with ForEach we have
                    /// the option to delete an index
                    ForEach(numbers, id: \.self) {
                        Text("\($0)")
                    }
                    .onDelete(perform: { indexSet in
                        removeRows(at: indexSet)
                    })
                }
                
                Button("Add number") {
                    self.numbers.append(self.currentNumber)
                    self.currentNumber += 1
                }
            }
            .navigationBarItems(leading: EditButton())
        }
    }
    
    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
    
}

struct OnDeleteView_Previews: PreviewProvider {
    static var previews: some View {
        OnDeleteView()
    }
}
