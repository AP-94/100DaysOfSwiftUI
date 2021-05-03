//
//  ContentView.swift
//  Animations
//
//  Created by Alessandro Pace on 28/2/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            Form  {
            NavigationLink(destination: CustomAnimation()) {
                                Text("Custom Animation")
                                .padding(10)
                                .foregroundColor(.black)
                                .font(.title2)
                        }
                NavigationLink(destination: HelloSwiftUI()) {
                                    Text("Hello SwuiftUI")
                                    .padding(10)
                                    .foregroundColor(.black)
                                    .font(.title2)
                            }
                NavigationLink(destination: StepperAndButton()) {
                                    Text("Stepper and Button")
                                    .padding(10)
                                    .foregroundColor(.black)
                                    .font(.title2)
                            }
                NavigationLink(destination: AnimatedButton()) {
                                    Text("Animated Button 1")
                                    .padding(10)
                                    .foregroundColor(.black)
                                    .font(.title2)
                            }
                NavigationLink(destination: AnimatedButtonTwo()) {
                                    Text("Animated Button 2")
                                    .padding(10)
                                    .foregroundColor(.black)
                                    .font(.title2)
                            }
                
            }
            .navigationBarTitle("Animations")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
