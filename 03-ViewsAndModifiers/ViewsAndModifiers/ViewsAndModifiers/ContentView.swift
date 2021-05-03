//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Alessandro Pace on 9/2/21.
//

import SwiftUI

struct LargeTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
            .padding()
    }
}

struct ContentView: View {
    var body: some View {
        Text("Test of custom view modifier")
            .titleStyle()
    }
}

extension View {
    func titleStyle() -> some View {
        self.modifier(LargeTitle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
