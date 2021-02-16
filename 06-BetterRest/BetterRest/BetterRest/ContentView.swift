//
//  ContentView.swift
//  BetterRest
//
//  Created by Alessandro Pace on 15/2/21.
//

import SwiftUI
import CoreML

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = Date()
    
    var body: some View {
        
        //STEPPER
        //        Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
        //            Text("\(sleepAmount, specifier: "%g") hours")
        //        }
        
        // DATES
//        var components = DateComponents()
//        components.hour = 8
//        components.minute = 0
//        let date = Calendar.current.date(from: components) ?? Date()
        
//        let components = Calendar.current.dateComponents([.hour, .minute], from: date)
//        let hour = components.hour ??
        
        DatePicker("Enter a date", selection: $wakeUp, displayedComponents: .hourAndMinute)
            .labelsHidden()
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
