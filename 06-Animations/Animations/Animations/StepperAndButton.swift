//
//  ContentView.swift
//  Animations
//
//  Created by Alessandro Pace on 21/2/21.
//

import SwiftUI

struct StepperAndButton: View {
    @State private var animationAmmount: CGFloat = 1
    
    var body: some View {
        print(animationAmmount)
        
        return VStack {
            Stepper ("Scale amount", value: $animationAmmount.animation(
                Animation.easeInOut(duration: 1)
                    .repeatForever(autoreverses: true)
            ), in: 1...10)
            
            Spacer()
            
            Button("Tap Me") {
                self.animationAmmount += 1
            }
            .padding(40)
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Circle())
            .scaleEffect(animationAmmount)
        }
    }
}

struct StepperAndButton_Previews: PreviewProvider {
    static var previews: some View {
        StepperAndButton()
    }
}
