//
//  MainView.swift
//  MainView
//
//  Created by Alessandro Pace on 3/8/21.
//

import CoreHaptics
import SwiftUI

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = CGFloat(total - position)
        return self.offset(CGSize(width: 0, height: offset * 10))
    }
}

enum SheetToShow {
    case editCards, config
}

struct MainView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityEnabled) var accessibilityEnabled
    
    @State private var cards: [Card] = []
    @State private var isActive = true
    @State private var timeRemaining = 5
    @State private var showingSheet = false
    @State private var isShowingGameOverAlert = false
    @State private var hapticsEngine: CHHapticEngine?
    @State private var sendToStackWrongCards = false
    @State private var sheetToShow = SheetToShow.editCards
    
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        
        ZStack {
            
            Image(decorative: "background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(
                        Capsule()
                            .fill(Color.black)
                            .opacity(0.75)
                    )
                
                ZStack {
                    ForEach(0..<cards.count, id: \.self) { index in
                        CardView(card: cards[index], retryWrongCards: sendToStackWrongCards, removal: { answerCorrect in
                            withAnimation {
                                if !answerCorrect {
                                    if sendToStackWrongCards {
                                        stackWrongCard(at: cards.count - 1)
                                        return
                                    }
                                }
                                removeCard(at: index)
                                
                            }
                        })
                            .stacked(at: index, in: cards.count)
                            .allowsHitTesting(index == cards.count - 1)
                            .accessibilityHidden(index < cards.count - 1)
                    }
                }
                .allowsHitTesting(timeRemaining > 0)
                
                if cards.isEmpty {
                    Button("Start Again", action: resetCards)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                }
            }
            
            VStack {
                HStack {
                    Button {
                        sheetToShow = .config
                        showingSheet = true
                    } label: {
                        Image(systemName: "gear")
                            .padding()
                            .background(Color.black.opacity(0.7))
                            .clipShape(Circle())
                    }
                    
                    Spacer()
                    
                    Button {
                        sheetToShow = .editCards
                        showingSheet = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(Color.black.opacity(0.7))
                            .clipShape(Circle())
                    }
                }
                
                Spacer()
            }
            
            .foregroundColor(.white)
            .font(.largeTitle)
            .padding()
            
            if differentiateWithoutColor || accessibilityEnabled {
                VStack {
                    Spacer()
                    
                    HStack {
                        Button(action: {
                            withAnimation {
                                if sendToStackWrongCards {
                                    stackWrongCard(at: cards.count - 1)
                                } else {
                                    removeCard(at: cards.count - 1 )
                                }
                            }
                        }) {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(Color.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibility(label: Text("Wrong"))
                        .accessibility(hint: Text("Mark yout answer as being incorrect."))
                        
                        Spacer()
                        
                        Button(action: {
                            withAnimation {
                                if sendToStackWrongCards {
                                    stackWrongCard(at: cards.count - 1)
                                } else {
                                    removeCard(at: cards.count - 1 )
                                }
                            }
                        }) {
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(Color.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibility(label: Text("Correct"))
                        .accessibility(hint: Text("Mark yout answer as being correct."))
                        
                    }
                    
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
                }
            }
        }
        
        .onReceive(timer) { time in
            guard isActive else { return }
            if timeRemaining > 0 {
                timeRemaining -= 1
                ///CHALLENGE 1: Show something when the time ends haptics and alert
                /// Enter only if time equals to 0 and cards is not empty
            } else if timeRemaining <= 0 && !cards.isEmpty {
                ///Remove cards to show the start again button in background
                timeOverHaptics()
                cards.removeAll()
                isShowingGameOverAlert = true
                
                ///Prepare haptics when timer is about to end
            } else if timeRemaining == 5 {
                prepareHaptics()
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            isActive = false
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            if cards.isEmpty == false {
                isActive = true
            }
        }
        .sheet(isPresented: $showingSheet, onDismiss: resetCards) {
            if sheetToShow == .editCards {
                EditCards()
            } else {
                ConfigView(wrongCardToogle: $sendToStackWrongCards)
            }
        }
        ///CHALLENGE 1: alert when time over
        .alert(isPresented: $isShowingGameOverAlert) {
            Alert(title: Text("Game Over"), message: Text("Want to play again?"), primaryButton: .default(Text("Go!")) {
                resetCards()
            }, secondaryButton: .cancel())
        }
        
        .onAppear(perform: resetCards)
    }
    
    private func loadData() {
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                cards = decoded
            }
        }
    }
    
    private func removeCard(at index: Int) {
        guard index >= 0 else { return }
        cards.remove(at: index)
        
        if cards.isEmpty {
            isActive = false
        }
    }
    
    private func resetCards() {
        timeRemaining = 50
        isActive = true
        loadData()
    }
    
    ///CHALLENGE 1: HAPTICS
    private func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            hapticsEngine = try CHHapticEngine()
            try? hapticsEngine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
    
    ///CHALLENGE 1: HAPTICS
    private func timeOverHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()
        
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
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
    
    private func stackWrongCard(at index: Int) {
        guard index >= 0 else { return }
        let card = cards[index]
        cards.remove(at: index)
        cards.insert(card, at: 0)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
