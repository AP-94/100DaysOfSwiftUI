//
//  ImageInterpolation.swift
//  ImageInterpolation
//
//  Created by Alessandro Pace on 31/7/21.
//

import SwiftUI

struct ImageInterpolation: View {
    
    var body: some View {
        
        Image("example")
            .interpolation(.none)
            .resizable()
            .scaledToFit()
            .frame(maxHeight: .infinity)
            .background(Color.black)
            .edgesIgnoringSafeArea(.all)
    }
}

struct ImageInterpolation_Previews: PreviewProvider {
    static var previews: some View {
        ImageInterpolation()
    }
}
