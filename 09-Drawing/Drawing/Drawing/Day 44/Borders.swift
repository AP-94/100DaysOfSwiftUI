//
//  SwiftUIView.swift
//  Drawing
//
//  Created by Alessandro Pace on 16/5/21.
//

import SwiftUI

struct BordersView: View {
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .frame(width: 300, height: 300)
            //.background(Color.red)
            //.border(Color.red, width: 30)
            //.background(Image("Memoji"))
            .border(ImagePaint(image: Image("Memoji"), sourceRect: CGRect(x: 0, y: 0.25, width: 1, height: 0.5), scale: 0.5), width: 30)
            
            Spacer()
            
            Capsule()
                .strokeBorder(ImagePaint(image: Image("Memoji"), scale: 0.1), lineWidth: 20)
                .frame(width: 300, height: 200)
        }
    }
}

struct BordersView_Previews: PreviewProvider {
    static var previews: some View {
        BordersView()
    }
}
