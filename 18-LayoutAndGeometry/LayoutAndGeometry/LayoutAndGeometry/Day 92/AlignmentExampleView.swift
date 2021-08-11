//
//  AlignmentExampleView.swift
//  AlignmentExampleView
//
//  Created by Alessandro Pace on 10/8/21.
//

import SwiftUI

struct AlignmentExampleView: View {
    var body: some View {
        VStack {
            Text("Live long and prosper")
                .frame(width: 300, height: 50, alignment: .topLeading)
            
            HStack(alignment: .lastTextBaseline) {
                Text("Live")
                    .font(.caption)
                Text("long")
                Text("and")
                    .font(.title)
                Text("prospet")
                    .font(.largeTitle)
            }
            
            VStack(alignment: .leading) {
                Text("Hello, world!")
                    .alignmentGuide(.leading) { d in
                        d[.trailing]
                    }
                
                Text("This is a longer line of text")
            }
            .background(Color.red)
            .frame(width: 400, height: 200)
            .background(Color.blue)
            
            VStack(alignment: .leading) {
                ForEach(0..<10) { position in
                    Text("Number \(position)")
                        .alignmentGuide(.leading) { _ in
                            CGFloat(position) * -10
                        }
                }
            }
            .background(Color.red)
            .frame(width: 400, height: 250)
            .background(Color.blue)
        }
        
    }
}

struct AlignmentExampleView_Previews: PreviewProvider {
    static var previews: some View {
        AlignmentExampleView()
    }
}
