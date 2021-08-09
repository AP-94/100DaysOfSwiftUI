//
//  TimerExamplesView.swift
//  TimerExamplesView
//
//  Created by Alessandro Pace on 3/8/21.
//

import SwiftUI

struct TimerExamplesView: View {
    let timer = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common).autoconnect()
    @State private var counter = 0
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onReceive(timer) { time in
                if counter == 5 {
                    timer.upstream.connect().cancel()
                } else {
                    print("The time is now \(time)")
                }
                
                counter += 1
            }
    }
}

struct TimerExamplesView_Previews: PreviewProvider {
    static var previews: some View {
        TimerExamplesView()
    }
}
