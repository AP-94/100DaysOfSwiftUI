//
//  ContentView.swift
//  WordScramble
//
//  Created by Alessandro Pace on 17/2/21.
//

import SwiftUI

struct Bundles: View {
    
    var body: some View {
        if let fileURL = Bundle.main.url(forResource: "", withExtension: "") {
            // we found the file in our bundle
            if let fileContents = try? String(contentsOf: fileURL) {
                // we loaded the file into a string
            }
        }
        
        let word = "swift"
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        let allGood = misspelledRange.location == NSNotFound
        
        Text("Dynamic row")
    }
}

struct Bundles_Previews: PreviewProvider {
    static var previews: some View {
        Bundles()
    }
}
