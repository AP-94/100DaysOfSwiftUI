//
//  ContentView.swift
//  Animations
//
//  Created by Alessandro Pace on 21/2/21.
//

import SwiftUI

struct AnimatedButtonTwo: View {
    @State private var animationAmmount = 360.0
    @State private var enabled = false
    
    var body: some View {
        VStack {
            Button("Tap Me") {
                withAnimation (.interpolatingSpring(stiffness: 5, damping: 5)) {
                    self.animationAmmount += 360
                }
            }
            .padding(50)
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Circle())
            .rotation3DEffect(
                .degrees(animationAmmount),
                axis: (x: 0, y: 1, z: 0))
        
        Button("Tap Me") {
            self.enabled.toggle()
        }
        .frame(width: 200, height: 200)
        .background(enabled ? Color.blue : Color.red)
        .animation(.default)
        .foregroundColor(.white)
        .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
        .animation(.default)
    }
    }
}

struct AnimatedButtonTwo_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedButtonTwo()
    }
}
