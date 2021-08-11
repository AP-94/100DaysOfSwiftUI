//
//  AbsolutePositionView.swift
//  AbsolutePositionView
//
//  Created by Alessandro Pace on 10/8/21.
//

import SwiftUI

struct AbsolutePositionView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .position(x: 100, y: 100)
            .offset(x: 100, y: 100)
            .background(Color.red)
    }
}

struct AbsolutePositionView_Previews: PreviewProvider {
    static var previews: some View {
        AbsolutePositionView()
    }
}
