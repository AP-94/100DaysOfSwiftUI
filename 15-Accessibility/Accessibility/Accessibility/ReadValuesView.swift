//
//  ReadValuesView.swift
//  Accessibility
//
//  Created by Alessandro Pace on 25/7/21.
//

import SwiftUI

struct ReadValuesView: View {
    
    @State private var estimate = 25.0
    @State private var rating = 3
    
    var body: some View {
        VStack {
            Slider(value: $estimate, in: 0...50)
                .accessibility(value: Text("\(Int(estimate))"))
                .padding()
            
            Stepper("Rate our service: \(rating)/5", value: $rating, in: 1...5)
                .accessibilityValue(Text("\(rating) out of 5"))
        }
    }
}

struct ReadValuesView_Previews: PreviewProvider {
    static var previews: some View {
        ReadValuesView()
    }
}
