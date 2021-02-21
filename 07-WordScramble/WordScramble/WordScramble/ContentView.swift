//
//  ContentView.swift
//  WordScramble
//
//  Created by Alessandro Pace on 17/2/21.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var score = 0
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showError = false
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Enter your word", text: $newWord, onCommit: addNewWord)
                        
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                    
                    //Added button to make UI better
                    Button(action: {
                        addNewWord()
                    }, label: {
                        Text("Add Word")
                    })
                    .padding()
                }
                
                
                List(usedWords, id: \.self) {
                    Image(systemName: "\($0.count).circle")
                    Text($0)
                }
                
                //Challenge 3: Score below list
                VStack (alignment: .center) {
                    Text("Score:")
                        .font(.headline)
                    Text("\(score)")
                        .font(.headline)
                        .foregroundColor(.blue)
                }
            }
            .navigationTitle(rootWord)
            //Challenge 2: Left bar button to change word
            .navigationBarItems(leading:
                                    Button(action: startGame) {
                                        Text("Change word")
                                    }
            )
            .onAppear(perform: startGame)
            .alert(isPresented: $showError, content: {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("Ok")))
            })
        }
    }
    
    func startGame() {
        if let fileURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: fileURL) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
        
        fatalError("Could not load start.txt from bundle.")
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else {
            return
        }
        
        //Challenge 1 Return error if the word is the same as root word.
        guard answer != rootWord else {
            showError(title: "Same root word", message: "I see what you did there :| You can't enter the same word")
            return
        }
        
        guard isOriginal(answer) else {
            showError(title: "Word used already", message: "Be more original")
            return
        }
        
        guard isPossible(answer) else {
            showError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        
        guard isRealWord(answer) else {
            showError(title: "Word not possible", message: "That isn't a real word!")
            return
        }
        
        //Challenge 3: Score variable change is value evertime
        // a word is valid.
        score += answer.count
        usedWords.insert(answer, at: 0)
        newWord = ""
    }
    
    func isOriginal(_ word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(_ word: String) -> Bool {
        var tempWord = rootWord.lowercased()
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isRealWord(_ word: String) -> Bool {
        
        //Challenge 1: returns false if the
        //word length is under three letters
        guard word.count > 2 else {
            return false
        }
        
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func showError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showError = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
