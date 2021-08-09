//
//  AllowsHitTestingView.swift
//  AllowsHitTestingView
//
//  Created by Alessandro Pace on 3/8/21.
//

import SwiftUI

struct AllowsHitTestingView: View {
    
    var body: some View {
        VStack {
            
            ZStack {
                
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: 300, height: 300)
                    .onTapGesture {
                        print("TRIANGLE tapped!")
                    }
                
                Circle()
                    .fill(Color.red)
                    .frame(width: 300, height: 300)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        print("CIRCLE tapped!")
                    }
                //.allowsHitTesting(false)
                
            }
            
            VStack {
                
                Text("Hello")
                Spacer().frame(height: 100)
                Text("World")
            }
            .contentShape(Rectangle()) //To avoid blanck spaces not triggering tap gesture
            .onTapGesture {
                print("VStack tapped!")
                
            }
        }
    }
}

struct AllowsHitTestingView_Previews: PreviewProvider {
    static var previews: some View {
        AllowsHitTestingView()
    }
}
