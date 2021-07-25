//
//  HidingAndGroupingView.swift
//  Accessibility
//
//  Created by Alessandro Pace on 25/7/21.
//

import SwiftUI

struct HidingAndGroupingView: View {
    var body: some View {
//        Image(decorative: "character")
//            .accessibilityHidden(true)
        
        VStack {
            Text("Your score is")
            Text("1000")
                .font(.title)
        }
        //.accessibilityElement(children: .combine)
        .accessibilityElement(children: .ignore)
        .accessibility(label: Text("Your score is 1000"))
    }
}

struct HidingAndGroupingView_Previews: PreviewProvider {
    static var previews: some View {
        HidingAndGroupingView()
    }
}
