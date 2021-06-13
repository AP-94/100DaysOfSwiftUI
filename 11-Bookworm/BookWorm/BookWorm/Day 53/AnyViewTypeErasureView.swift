//
//  AnyViewTypeErasureView.swift
//  BookWorm
//
//  Created by Alessandro Pace on 2/6/21.
//

import SwiftUI

struct AnyViewTypeErasureView: View {
    
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        
        if sizeClass == .compact {
            return AnyView(HStack {
                Text("Active size class:")
                Text("COMPACT")
            }.font(.largeTitle))
        } else {
            return AnyView(VStack {
                Text("Active size class:")
                Text("REGULAR")
            }.font(.largeTitle))
        }
    }
}

struct AnyViewTypeErasureView_Previews: PreviewProvider {
    static var previews: some View {
        AnyViewTypeErasureView()
    }
}
