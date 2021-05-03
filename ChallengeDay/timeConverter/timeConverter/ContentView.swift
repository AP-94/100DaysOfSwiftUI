//
//  ContentView.swift
//  timeConverter
//
//  Created by Alessandro Pace on 2/2/21.
//

import SwiftUI

struct ContentView: View {
    @State private var unitFromPosition = 0
    @State private var unitForPosition = 1
    @State private var quantityToConvert = ""
    
    let timeUnits = ["Seconds","Minutes","Hours","Days"]
    
    private var convertedValue: Double {
       let quantityInSeconds = convertQuantityEnteredToSeconds(Double(quantityToConvert) ?? 0)
        
        return convertQuantityToNewUnit(from: quantityInSeconds, to: timeUnits[unitForPosition])
    }
    
    func convertQuantityEnteredToSeconds(_ quantity: Double) -> Double {
        var quantityInSeconds: Double = 0
        
        switch timeUnits[unitFromPosition] {
        case "Seconds":
            quantityInSeconds = quantity
        case "Minutes":
            quantityInSeconds = quantity * 60
        case "Hours":
            quantityInSeconds = quantity * 3600
        case "Days":
            quantityInSeconds = quantity * 86400
        default:
            print("error")
        }
        
        return quantityInSeconds
    }
    
    func convertQuantityToNewUnit(from seconds: Double, to unit: String) -> Double {
        var finalValue = 0.0
        let secondsMeasure = Measurement(value: seconds, unit: UnitDuration.seconds)
        
        switch unit {
        case "Seconds":
            finalValue = seconds
        case "Minutes":
            finalValue = secondsMeasure.converted(to: .minutes).value
        case "Hours":
            finalValue = secondsMeasure.converted(to: .hours).value
        case "Days":
            finalValue = secondsMeasure.converted(to: .hours).value / 24
        default:
            print("error")
        }
        
        
        return finalValue
    }
    
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Unit From:")) {
                    Picker("Time Units", selection: $unitFromPosition) {
                        ForEach(0 ..< timeUnits.count) {
                            Text("\(self.timeUnits[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section {
                    TextField("Quantity in \(timeUnits[unitFromPosition])", text: $quantityToConvert).keyboardType(.decimalPad)
                }
                
                Section(header: Text("Time unit you want:")) {
                    Picker("Time Units", selection: $unitForPosition) {
                        ForEach(0 ..< timeUnits.count) {
                            Text("\(self.timeUnits[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Quantity in \(timeUnits[unitForPosition]):")) {
                    Text("\(convertedValue, specifier: "%.1f")")
                }
            }
            .navigationBarTitle("Time Converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
