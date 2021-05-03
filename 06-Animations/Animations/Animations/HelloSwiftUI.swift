//
//  ContentView.swift
//  Animations
//
//  Created by Alessandro Pace on 21/2/21.
//

import SwiftUI

struct HelloSwiftUI: View {
    @State private var drawAmount = CGSize.zero
    
    let letters = Array("Hello SwiftUI")
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero
    
    var body: some View {
        
        //        LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.red]), startPoint: .topLeading, endPoint: .bottomTrailing)
        //            .frame(width: 300, height: 200)
        //            .clipShape(RoundedRectangle(cornerRadius: 10))
        //            .offset(drawAmount)
        //            .gesture(
        //                DragGesture()
        //                    .onChanged { self.drawAmount = $0.translation }
        //                    .onEnded { _ in
        //                        withAnimation(.spring()) {
        //                            self.drawAmount = .zero
        //                        }}
        //            )
        
        HStack(spacing: 0) {
            ForEach(0..<letters.count) { num in
                Text(String(self.letters[num]))
                    .padding(5)
                    .font(.title)
                    .background(self.enabled ? Color.blue : Color.red)
                    .offset(self.dragAmount)
                    .animation(Animation.default.delay(Double(num / 20)))
            }
        }
        .gesture(
            DragGesture()
                .onChanged { self.dragAmount = $0.translation }
                .onEnded { _ in
                        self.dragAmount = .zero
                        self.enabled.toggle()
                    }
        )
    }
}

struct HelloSwiftUI_Previews: PreviewProvider {
    static var previews: some View {
        HelloSwiftUI()
    }
}
