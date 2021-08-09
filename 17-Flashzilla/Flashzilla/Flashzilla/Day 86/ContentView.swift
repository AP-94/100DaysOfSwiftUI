//
//  ContentView.swift
//  Flashzilla
//
//  Created by Alessandro Pace on 2/8/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var currentAmount: CGFloat = 0
    @State private var finalAmount: CGFloat = 1
    @State private var rotationCurrentAmount: Angle = .degrees(0)
    @State private var rotationFinalAmount: Angle = .degrees(0)
    @State private var offSet = CGSize.zero
    @State private var isDragging = false
    
    var body: some View {
        let dragGesture = DragGesture()
            .onChanged { value in self.offSet = value.translation }
            .onEnded { _ in
                withAnimation {
                    self.offSet = .zero
                    self.isDragging = false
                }
            }
        
        let pressGesture = LongPressGesture()
            .onEnded { value in
                withAnimation {
                    self.isDragging = true
                }
            }
        
        let combined = pressGesture.sequenced(before: dragGesture)
        
        VStack {
            Text("Hello, world! Long press me")
                .padding()
                .onLongPressGesture(minimumDuration: 1, pressing: {
                    inProgress in
                    print("In progress: \(inProgress)!")
                }) {
                    print("LONG PRESSS :D ")
                }
            
            Text("Hello, world! Try to scale me")
                .padding()
                .scaleEffect(finalAmount + currentAmount)
                .gesture(
                    MagnificationGesture()
                        .onChanged { amount in
                            self.currentAmount = amount + 1
                        }
                        .onEnded { amount in
                            self.finalAmount += self.currentAmount
                            self.currentAmount = 0
                        }
                )
            
            Text("Hello, world! Try to rotate me")
                .padding()
                .rotationEffect(rotationFinalAmount + rotationCurrentAmount)
                .highPriorityGesture(
                    //can be .simultaneousGesture to tigger several gesture at the same time
                    RotationGesture()
                        .onChanged { angle in
                            self.rotationCurrentAmount = angle
                        }
                        .onEnded { angle in
                            self.rotationFinalAmount += self.rotationCurrentAmount
                            self.rotationCurrentAmount = .degrees(0)
                        }
                )
            
            Circle()
                .fill(Color.red)
                .frame(width: 64, height: 64)
                .scaleEffect(isDragging ? 1.5 : 1)
                .offset(offSet)
                .gesture(combined)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
