//
//  GeometryReaderExamplesvIEW.swift
//  GeometryReaderExamplesvIEW
//
//  Created by Alessandro Pace on 10/8/21.
//

import SwiftUI

struct OuterView: View {
    var body: some View {
        VStack {
            Text("Top")
            InnerView()
                .background(Color.green)
            Text("Bottom")
        }
    }
}

struct InnerView: View {
    var body: some View {
        HStack {
            Text("Left")
            GeometryReader { geo in
                Text("Center")
                    .background(Color.blue)
                    .onTapGesture {
                        print("Global center: \(geo.frame(in: .global).midX) x \(geo.frame(in: .global).midY)")
                        print("Custom center: \(geo.frame(in: .named("Custom")).midX) x \(geo.frame(in: .named("Custom")).midY)")
                        print("Local center: \(geo.frame(in: .local).midX) x \(geo.frame(in: .local).midY)")
                    }
            }
            .background(Color.orange)
            Text("Right")
        }
    }
}

struct GeometryReaderExamplesvIEW: View {
    var body: some View {
        //        VStack {
        //            GeometryReader { geo in
        //                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        //                    .frame(width: geo.size.width * 0.9, height: 40)
        //                    .background(Color.red)
        //            }
        //            .background(Color.green)
        //
        //            Text("More text")
        //                .background(Color.blue)
        //        }
        OuterView()
            .background(Color.red)
            .coordinateSpace(name: "Custom")
    }
}

struct GeometryReaderExamplesvIEW_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReaderExamplesvIEW()
    }
}
