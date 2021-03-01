//
//  ContentView.swift
//  Project6Challenges
//
//  Created by Alessandro Pace on 28/2/21.
//

import SwiftUI

// Project 3 Challenge

struct FlagImage: View {
    var name: String
    
    var body: some View {
        Image(name)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}

struct Shake: GeometryEffect {
    var amount: CGFloat = 10
    var shakesPerUnit = 3
    var animatableData: CGFloat

    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX:
            amount * sin(animatableData * .pi * CGFloat(shakesPerUnit)),
            y: 0))
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia","France","Germany","Ireland","Italy", "Nigeria", "Poland", "Russia","Spain","UK","US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var attempts = [0, 0, 0]
    
//    Project 6 / Challenge 1
    @State private var spinYAnimationAmounts = [0.0, 0.0, 0.0]
    
//    Project 6 / Challenge 2
    @State private var changeOpacity = false

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                        .bold()

                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        //Project 3 challenge
                        FlagImage(name: self.countries[number])
                            //Project 6 challenges
                            .rotation3DEffect(
                                .degrees(self.spinYAnimationAmounts[number]),
                                axis: (x: 0, y: 1, z: 0))
                            .opacity(self.changeOpacity ? (number == correctAnswer ? 1 : 0.25) : 1)
                            .modifier(Shake(animatableData: CGFloat(attempts[number])))
                    }
                }
                
                VStack {
                    Text("Score")
                        .foregroundColor(.white)
                        .font(.title)
                        .fontWeight(.bold)
                    Text("\(score)")
                        .foregroundColor(.green)
                        .font(.title)
                        .fontWeight(.black)
                }
                
                Spacer()
                
            }
        }
    }
    
    func flagTapped(_ number: Int) {
        
        //Opacity change
        withAnimation (Animation.easeInOut(duration: 0.5)) {
            self.changeOpacity = true
        }
        
        if number == correctAnswer {
            
            //360 degrees animation
            withAnimation (.interpolatingSpring(stiffness: 10, damping: 5)) {
                self.spinYAnimationAmounts[number] += 360
                score += 1
            }
          
        } else {
            
            //Shake animation challenge 3
            withAnimation (.default) {
                self.attempts[number] += 1
                
                if score != 0 {
                    score -= 1
                }
            }
            
        }
        
        // DispatchQueue with delay for let the animations play normal and letting the user the time to see if the answer was right or bad
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    self.askQuestion()
                }
    }
    
    func askQuestion() {
        
        //Changing the opacity to false again
        changeOpacity = false
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

