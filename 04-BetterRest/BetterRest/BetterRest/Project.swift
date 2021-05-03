//
//  Project.swift
//  BetterRest
//
//  Created by Alessandro Pace on 16/2/21.
//

import SwiftUI
import CoreML

struct Project: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = defaultWakeTime
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            Form {
                
                ///Challenge 1
                // "change VSTACK for section", added section
                // but didnt remove stack to create the view without
                // the line
                Section {
                    VStack (alignment: .leading, spacing: 10) {
                        
                        Text("When do you want to wake up?")
                            .font(.headline)
                        DatePicker("Enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                    }
                    
                    
                }
                
                ///Challenge 1
                // "change VSTACK for section", added section
                // but didnt remove stack to create the view without
                // the line
                Section {
                    VStack (alignment: .leading, spacing: 10) {
                        Text("Desired amount of sleep")
                            .font(.headline)
                        
                        Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                            Text("\(sleepAmount, specifier: "%g") hours")
                        }
                    }}
                
                ///Challenge 1
                // "change VSTACK for section, added section
                // but didnt remove stack to create the view without
                // the line
                Section {
                    VStack (alignment: .leading, spacing: 10) {
                        
                        ///Challenge 2
                        // Changed Stepper for Picker, used the same IF, but
                        // with a small modification to achieve better UI
                        Picker("Daily coffe intake", selection: $coffeeAmount) {
                            ForEach(1..<21) {
                                if $0 == 1 {
                                    Text("1 cup")
                                } else {
                                    Text("\($0) cups")
                                }
                                
                            }
                        }
                        .font(.headline)
                        
                        //                    Stepper(value: $coffeeAmount, in: 1...20) {
                        //                        if coffeeAmount == 1 {
                        //                            Text("1 cup")
                        //                        } else {
                        //                            Text("\(coffeeAmount) cups")
                        //                        }
                        //                    }
                    }
                }
                
                ///Challenge 3
                // "Put the result in screen" I removed the calculate
                // button, and modified the calculatedBedTime func to
                // return a STRING to be able to use it
                // in a Text component
                
                VStack (alignment: .leading, spacing: 10) {
                    Text("Your ideal bedtime is:")
                        .font(.headline)
                    Text(calculateBedTime())
                        .font(.headline)
                        .foregroundColor(.blue)
                }
               
            }
            
                
            .navigationBarTitle("BetterRest")
//            .navigationBarItems(trailing:
//                                    Button(action: calculateBedTime) {
//                                        Text("Calculate")
//                                    }
//            )
            
            .alert(isPresented: $showingAlert, content: {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Ok")))
            })
        }
    }
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
    func calculateBedTime() -> String {
        var result = ""
        
        let model = SleepCalculator()
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        
        do {
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = .short
            
            result = dateFormatter.string(from: sleepTime)
            //alertMessage = dateFormatter.string(from: sleepTime)
            //alertTitle = "Your ideal bedtime is..."
        } catch {
            //alertTitle = "Error"
            //alertMessage = "Sorry, there was a problem calculating your bedtime."
            result = "Sorry, there was a problem calculating your bedtime."
        }
        
        return result
        
        //showingAlert = true
        
    }
}

struct Project_Previews: PreviewProvider {
    static var previews: some View {
        Project()
    }
}
