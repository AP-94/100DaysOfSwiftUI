//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Alessandro Pace on 23/8/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        NavigationView {
            
            NavigationLink(destination: Text("New Secondary View")) {
                Text("Hello, world!")
            }
            
            .navigationTitle("Primary View")
            
            Text("Secondary View")
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
