//
//  ContentView.swift
//  SplitThat
//
//  Created by Alessandro Pace on 27/1/21.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = ""
    @State private var tipPercentage = 2
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    private var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople) ?? 1
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        let tipAmount = (orderAmount * tipSelection)/100
        let totalAmount = tipAmount + orderAmount
        let amountPerPerson = totalAmount / peopleCount

        return amountPerPerson
        
    }
    
    private var totalWithTip: Double {
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipAmount = (orderAmount * tipSelection)/100
        let totalAmount = tipAmount + orderAmount

        return totalAmount
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount).keyboardType(.decimalPad)
//                    Picker("Number of people", selection: $numberOfPeople) {
//                        ForEach(2 ..< 20) {
//                            Text("\($0)")
//                        }
//                    }
                    TextField("Number of people", text: $numberOfPeople).keyboardType(.decimalPad)
                }
                
                Section(header: Text("Tip you want to leave:")) {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count ) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Total with tip:")) {
                    Text("\(totalWithTip, specifier: "%.2f") €")
                }
                
                Section(header: Text("Amount per person:")) {
                    Text("\(totalPerPerson, specifier: "%.2f") €")
                }
                
                
            }
            .navigationBarTitle("SpliteWise 1.0")
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 11")
    }
}
