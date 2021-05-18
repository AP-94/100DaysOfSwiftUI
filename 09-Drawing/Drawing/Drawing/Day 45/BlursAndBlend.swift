//
//  BlursAndBlend.swift
//  Drawing
//
//  Created by Alessandro Pace on 17/5/21.
//

import SwiftUI

struct BlursAndBlend: View {
    
    @State private var amount: CGFloat = 0.0
    
    var body: some View {
//        ZStack {
//            Image("Memoji")
//
//            Rectangle()
//                .fill(Color.red)
//                .blendMode(.multiply)
//        }
//        .frame(width: 400, height: 500)
//        .clipped()
        
        //Alike result less code
        //Image("Memoji")
              //  .colorMultiply(.red)
        
        VStack {
                    ZStack {
                        Circle()
                            .fill(Color(red: 1, green: 0, blue: 0))
                            .frame(width: 200 * amount)
                            .offset(x: -50, y: -80)
                            .blendMode(.screen)

                        Circle()
                            .fill(Color(red: 0, green: 1, blue: 0))
                            .frame(width: 200 * amount)
                            .offset(x: 50, y: -80)
                            .blendMode(.screen)

                        Circle()
                            .fill(Color(red: 0, green: 0, blue: 1))
                            .frame(width: 200 * amount)
                            .blendMode(.screen)
                    }
                    .frame(width: 300, height: 300)

                    Slider(value: $amount)
                        .padding()
            
            Image("Memoji")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .saturation(Double(amount))
                .blur(radius: (1 - amount) * 20)
            
            
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black)
                .edgesIgnoringSafeArea(.all)
            }
}

struct BlursAndBlend_Previews: PreviewProvider {
    static var previews: some View {
        BlursAndBlend()
    }
}
