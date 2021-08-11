//
//  GeometryScrollViewView.swift
//  GeometryScrollViewView
//
//  Created by Alessandro Pace on 10/8/21.
//

import SwiftUI

struct GeometryScrollViewView: View {
    
    let colors: [Color] = [.red, .green, .yellow, .gray, .blue, .purple, .orange]
    
    var body: some View {
        GeometryReader { fullView in
            ScrollView(.vertical) {
                ForEach(0..<50) { index in
                    GeometryReader { geo in
                        Text("Row #\(index)")
                            .font(.title)
                            .frame(width: fullView.size.width)
                            .background(self.colors[index % 7])
                            .rotation3DEffect(.degrees(Double(geo.frame(in: .global).minY - fullView.size.height / 2) / 5), axis: (x: 0, y: 1, z: 0))
                    }
                    .frame(height: 40)
                }
            }
        }
    }
}

struct GeometryScrollViewView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryScrollViewView()
    }
}
