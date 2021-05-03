//
//  GameView.swift
//  MultiplicationTables
//
//  Created by Alessandro Pace on 26/4/21.
//

import SwiftUI

struct GameView: View {
    
    @ObservedObject var settingsToggle: SettingsToggle
    @ObservedObject var gameData: GameData
    
    @State private var userAnswer = ""
    @State private var currentQuestion = 0
    @State private var score = 0
    @State private var endGame = false
    @State private var goodAnswered = false
    @State private var badAnswered = false
    

    var body: some View {
            VStack(alignment: .leading) {
                HStack {
                    Text("\(gameData.allQuestions[currentQuestion].firstNumber)")
                        .font(.system(size: 30))
                        .frame(minWidth: 0, maxWidth: 50, minHeight: 0, maxHeight: 100, alignment: .center)
                        .foregroundColor(Color.white)
                        .background(Color.green)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    Text("X")
                        .font(.system(size: 30))
                        .frame(minWidth: 0, maxWidth: 50, minHeight: 0, maxHeight: 100, alignment: .center)
                        .foregroundColor(Color.red)
                    
                    Text("\(gameData.allQuestions[currentQuestion].secondNumber)")
                        .font(.system(size: 30))
                        .frame(minWidth: 0, maxWidth: 50, minHeight: 0, maxHeight: 100, alignment: .center)
                        .foregroundColor(Color.white)
                        .background(Color.green)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    Text("=")
                        .font(.system(size: 30))
                        .frame(minWidth: 0, maxWidth: 50, minHeight: 0, maxHeight: 100, alignment: .center)
                        .foregroundColor(Color.red)
                    
                    
                    TextField("", text: $userAnswer)
                        .font(.system(size: 30))
                        .foregroundColor(.blue)
                        .keyboardType(.decimalPad)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 100, alignment: .center)
                        .background(Color.gray.opacity(0.3))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50, alignment: .center)
                .padding()
                
                Button(action: submitAnswer) {
                    Text("Submit")
                }.font(.system(size: 40))
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 70, alignment: .center)
                .foregroundColor(Color.white)
                .background(Color.orange)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding()
                
                HStack {
                    Text("Question \n\(currentQuestion + 1)/\(gameData.numberOfQuestions)")
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 100, alignment: .center)
                        .background(Color.green)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding()
                    
                    
                    Text("Score \(score)")
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 100, alignment: .center)
                        .foregroundColor(Color.white)
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding()
                }
                
                ZStack {
                    Text("NICE!! 1 POINT!")
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 100, alignment: .center)
                        .foregroundColor( goodAnswered ? Color.green : Color.clear)
                        .padding()
                    
                    Text(":( 0 POINTS!")
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 100, alignment: .center)
                        .foregroundColor( badAnswered ? Color.red : Color.clear)
                        .padding()
                }
                
                Spacer()
            }
            .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity, minHeight: 0, idealHeight: 0, maxHeight: .infinity, alignment: .leading)
            .alert(isPresented: $endGame) {
                Alert(title: Text("Game Over"), message: Text("Your final score is: \(score)/\(gameData.numberOfQuestions)"), dismissButton: .default(Text("Play Again"), action: {
                    self.goToSettings()
                }))
            }
    }
    
    func submitAnswer() {
        
        if currentQuestion >= gameData.allQuestions.count - 1 {
            endGame = true
        } else {
            if gameData.allQuestions[currentQuestion].answer == Int(userAnswer) {
                
                withAnimation(Animation.easeOut) {
                    badAnswered = false
                }
                
                withAnimation(Animation.linear(duration: 1)) {
                    goodAnswered = true
                }
                
                score += 1
            } else {
                withAnimation(Animation.easeOut) {
                    goodAnswered = false
                }
                
                withAnimation(Animation.easeInOut(duration: 2)) {
                    badAnswered = true
                }
            }
            
            currentQuestion += 1
        }
        
        userAnswer = ""
    }
    
    func goToSettings() {
        settingsToggle.gameStarted = false
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(settingsToggle: SettingsToggle(), gameData: GameData())
    }
}
