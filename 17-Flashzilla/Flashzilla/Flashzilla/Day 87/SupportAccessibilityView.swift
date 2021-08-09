//
//  SupportAccessibilityView.swift
//  SupportAccessibilityView
//
//  Created by Alessandro Pace on 3/8/21.
//

import SwiftUI

func withOptionalAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result {
    if UIAccessibility.isReduceMotionEnabled {
        return try body()
    } else {
        return try withAnimation(animation, body)
    }
}

struct SupportAccessibilityView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency
    @State private var scale: CGFloat = 1
    
    var body: some View {
        HStack {
            if differentiateWithoutColor {
                Image(systemName: "checkmark.circle")
            }
            
            Text("Success")
                .padding(50)
                .scaleEffect(scale)
                .onTapGesture {
                    withOptionalAnimation {
                        self.scale *= 1.5
                    }
                }
                .background(reduceTransparency ? Color.black : Color.black.opacity(0.5))
                .foregroundColor(.white)
                .clipShape(Circle())
        }
        .padding()
        .background(differentiateWithoutColor ? Color.black : Color.green)
        .foregroundColor(.white)
        .clipShape(Capsule())
    }
}

struct SupportAccessibilityView_Previews: PreviewProvider {
    static var previews: some View {
        SupportAccessibilityView()
    }
}
