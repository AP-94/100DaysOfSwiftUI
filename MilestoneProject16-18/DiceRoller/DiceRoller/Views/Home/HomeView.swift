//
//  HomeView.swift
//  HomeView
//
//  Created by Alessandro Pace on 12/8/21.
//

import CoreHaptics
import SwiftUI

struct HomeView: View {
    @Environment(\.managedObjectContext) var moc
    
    let sides = [4, 6, 8, 10, 12, 20, 100]
    
    let timer = Timer.publish(every: 0.15, on: .main, in: .common).autoconnect()
    
    @State private var rollTime = 2.0
    @State private var rollActive = false
    @State private var dicesToRoll: [Dice] = []
    @State private var selectedDices = 0
    @State private var selectedNumberOfSides = 0
    @State private var rolledDicesTotal = 0
    @State private var showingEmptyFieldsAlert = false
    @State private var hapticsEngine: CHHapticEngine?
    
    var body: some View {
        NavigationView {
            
            VStack {
                VStack(alignment: .leading) {
                    Text("Number of dices:")
                        .font(.headline)
                        .padding([.leading, .top])
                    Picker("", selection: $selectedDices) {
                        ForEach(1...6, id: \.self) { number in
                            Text("\(number)")
                        }
                    }
                    .pickerStyle(.segmented)
                    .onChange(of: selectedDices, perform: { newDices in
                        setDices()
                    })
                    .padding()
                }
                
                VStack(alignment: .leading) {
                    Text("Number of sides:")
                        .font(.headline)
                        .padding([.leading, .top])
                    Picker("", selection: $selectedNumberOfSides) {
                        ForEach(sides, id: \.self) { side in
                            Text("\(side)")
                        }
                    }
                    .pickerStyle(.segmented)
                    .onChange(of: selectedNumberOfSides, perform: { _ in
                        setDices()
                    })
                    .padding()
                }
                
                VStack(alignment: .leading) {
                    Text("Dices:")
                        .font(.title)
                        .fontWeight(.heavy)
                        .padding(.top)
                }
                
                HStack {
                    ForEach(dicesToRoll, id: \.self) { dice in
                        DiceView(dice: dice, dicePosition: getDicePosition(for: dice))
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.top)
                
                Spacer()
                
                HStack {
                    Text("Total: ")
                        .fontWeight(.medium)
                    Text("\(rolledDicesTotal)")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(Color.green)
                }
                
                
                
                Button("ROLL DICES") {
                    rollDicesButton()
                }
                .frame(maxHeight: 60)
                .font(.title.bold())
                .foregroundColor(.orange)
                .padding([.leading, .trailing])
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.green, lineWidth: 2)
                )
                .padding(.bottom)
                
                Spacer()
                
                
            }
            
            
            .navigationTitle("Dice Roller")
            .navigationBarItems(trailing: Button("Save Result") {
                saveResult()
            })
        }
        .alert(isPresented: $showingEmptyFieldsAlert) {
            Alert(title: Text("Fields empty"), message: Text("You must select at least one dice and one number of sides to roll the dices"), dismissButton: .default(Text("Ok")))
        }
        .onReceive(timer) { time in
            if rollActive {
                if rollTime > 0 {
                    rollTime -= 0.25
                    rollDices()
                } else {
                    playHaptics()
                    getSumOfRolledDices()
                }
            }
        }
    }
    
    private func setDices() {
        dicesToRoll.removeAll()
        
        for _ in 0..<selectedDices {
            dicesToRoll.append(Dice(number: 0))
        }
    }
    
    private func getDicePosition(for dice: Dice) -> Int {
        return (dicesToRoll.firstIndex(of: dice) ?? 0) + 1
    }
    
    private func rollDicesButton() {
        rollActive = true
        rollTime = 5.0
    }
    
    private func rollDices() {
        guard selectedDices != 0, selectedNumberOfSides != 0 else {
            showingEmptyFieldsAlert = true
            return
        }
        
        rolledDicesTotal = 0
        
        withAnimation {
            for i in 0..<selectedDices {
                dicesToRoll[i].number = Int.random(in: 1..<(selectedNumberOfSides + 1))
            }
        }
        
    }
    
    private func getSumOfRolledDices() {
        rolledDicesTotal = 0
        
        dicesToRoll.forEach { dice in
            rolledDicesTotal += dice.number
        }
    }
    
    private func saveResult() {
        guard rolledDicesTotal != 0 else {
            return
        }
        
        let newDiceRoll = DiceRoll(context: moc)
        newDiceRoll.date = Date()
        newDiceRoll.numberOfDices = Int16(selectedDices)
        newDiceRoll.sides = Int16(selectedNumberOfSides)
        newDiceRoll.result = Int16(rolledDicesTotal)
        
        if moc.hasChanges {
            do {
                try self.moc.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            hapticsEngine = try CHHapticEngine()
            try? hapticsEngine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
    
    private func playHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()
        
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.3)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.3)
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        events.append(event)
        
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try hapticsEngine?.makePlayer(with: pattern)
            
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
