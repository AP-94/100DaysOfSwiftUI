//
//  ContentView.swift
//  Instafilter
//
//  Created by Alessandro Pace on 28/6/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var blurAmount: CGFloat = 0 {
        didSet {
            print("New value is \(blurAmount)")
        }
    }
    
    var body: some View {
        
        let blur = Binding<CGFloat>(
            get: {
                blurAmount
            },
            
            set: {
                blurAmount = $0
                print("New value is ", blurAmount)
            }
        )
        
        VStack {
            Text("Hello, world!")
                .blur(radius: blurAmount)
            
            Slider(value: blur, in: 0...20)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
