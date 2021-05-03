//
//  ContentView.swift
//  Animations
//
//  Created by Alessandro Pace on 21/2/21.
//

import SwiftUI

struct AnimatedButton: View {
    @State private var animationAmmount: CGFloat = 1
    
    var body: some View {
        Button("Tap me") {
           // self.animationAmmount += 1
        }
        .padding(50)
        .background(Color.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .overlay(
            Circle()
                .stroke(Color.red)
                .scaleEffect(animationAmmount)
                .opacity(Double(2 - animationAmmount))
                .animation(
                    Animation.easeInOut(duration: 1)
                        .repeatForever(autoreverses: false)
        )
        //.scaleEffect(animationAmmount)
       // .blur(radius: (animationAmmount - 1) * 3)
//        .animation(
//            Animation.easeInOut(duration: 1)
//                .repeatForever(autoreverses: true)
        )
        .onAppear {
            self.animationAmmount = 2
        }
    }
}

struct AnimatedButton_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedButton()
    }
}
