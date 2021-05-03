//
//  ContentView.swift
//  rockPaperScissors
//
//  Created by Alessandro Pace on 11/2/21.
//

import SwiftUI

struct MoveImage: View {
    var name: String
    var borderColor: Color
    
    var body: some View {
        Image(name)
            .renderingMode(.original)
            .clipShape(Capsule())
            .padding(10)
            .overlay(Capsule().stroke(borderColor, lineWidth: 2))
            .shadow(color: .black, radius: 2)
    }
}

struct ContentView: View {
    private var moves = ["Rock", "Paper", "Scissors"]
    
    @State private var winOrLose = Bool.random()
    @State private var appMove = Int.random(in: 0...2)
    @State private var score = 0
    @State private var question = 0
    @State private var endGame = false
    @State private var move = ""
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30){
                VStack {
                    Text("Rock, Paper & Scissors")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()
                    
                    Text("Phone move")
                        .foregroundColor(.white)
                        .font(.title)
                        .fontWeight(.regular)
                        .padding()
                    
                    MoveImage(name: self.moves[appMove], borderColor: .red)
                    
                    HStack {
                        Text("Choose your move to:")
                            .foregroundColor(.white)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text("\(winOrLose ? "Win" : "Lose")")
                            .foregroundColor(winOrLose ? .green : .red)
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    .padding()
                    
                }
                
                HStack(spacing: 30) {
                    ForEach(0 ..< 3) { number in
                        Button(action: {
                            move = self.moves[number]
                            self.playerSelectedMove(self.moves[number])
                        }) {
                            VStack {
                                MoveImage(name: self.moves[number], borderColor: .white)
                                Text(self.moves[number])
                                    .foregroundColor(.white)
            
                            }
                           
                        }
                    }
                }
                
                VStack {
                    VStack {
                        Text("Your  Score")
                            .foregroundColor(.white)
                            .font(.title)
                            .fontWeight(.bold)
                        Text("\(score)")
                            .foregroundColor(.green)
                            .font(.title)
                            .fontWeight(.black)
                            .padding()
                    }
                }
                
                
    
                Spacer()
            }
            .alert(isPresented: $endGame) {
                Alert(title: Text("Game Over"), message: Text("Your final score is: \(score)"), dismissButton: .default(Text("Play Again"), action: {
                    self.restartGame()
                }))
            }
           
        }
        
    }
    
    func playerSelectedMove(_ move: String) {
        question += 1
        setScore(move)
        if question == 10 {
            endGame = true
        } else {
            self.move = ""
            winOrLose = Bool.random()
            appMove = Int.random(in: 0...2)
        }
        
    }
    
    func setScore(_ move: String) {
        if winOrLose {
            switch self.moves[appMove] {
            case "Rock":
                if move == "Paper" {
                    score += 1
                } else {
                    score -= 1
                }
            case "Paper":
                if move == "Scissors" {
                    score += 1
                } else {
                    score -= 1
                }
            case "Scissors":
                if move == "Rock" {
                    score += 1
                } else {
                    score -= 1
                }
            default:
                break
            }
        } else {
            switch self.moves[appMove] {
            case "Rock":
                if move != "Paper" {
                    score += 1
                } else {
                    score -= 1
                }
            case "Paper":
                if move != "Scissors" {
                    score += 1
                } else {
                    score -= 1
                }
            case "Scissors":
                if move != "Rock" {
                    score += 1
                } else {
                    score -= 1
                }
            default:
                break
            }
        }
    }

    func restartGame() {
        endGame = false
        score = 0
        question = 0
        winOrLose = Bool.random()
        appMove = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
