//
//  StrokeBorderView.swift
//  Drawing
//
//  Created by Alessandro Pace on 7/5/21.
//

import SwiftUI

struct StrokeBorderView: View {
    var body: some View {
        Arc(startAngle: .degrees(-90), endAngle: .degrees(90), clockwise: true)
            .strokeBorder(Color.blue, lineWidth: 40)
    }
}

struct StrokeBorderView_Previews: PreviewProvider {
    static var previews: some View {
        StrokeBorderView()
    }
}
