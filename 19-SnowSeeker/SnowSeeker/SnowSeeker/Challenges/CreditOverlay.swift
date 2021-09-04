//
//  CreditOverlay.swift
//  CreditOverlay
//
//  Created by Alessandro Pace on 4/9/21.
//

import SwiftUI

struct CreditOverlay: View {
    
    let creditText: String
    
    var body: some View {
        ZStack(alignment: .trailing) {
            Text("Photo Credit: \(creditText)")
                .font(.caption2)
                .padding(6)
                .foregroundColor(.white)
        }.background(Color.gray)
            .opacity(0.9)
            .cornerRadius(10.0)
            .padding(6)
    }
}

struct CreditOverlay_Previews: PreviewProvider {
    static var previews: some View {
        CreditOverlay(creditText: "Ricardo Gomez")
    }
}
