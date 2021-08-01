//
//  ObectChangeView.swift
//  ObectChangeView
//
//  Created by Alessandro Pace on 31/7/21.
//

import SwiftUI

class DelayedUpdater: ObservableObject {
    var value = 0 {
        willSet {
            objectWillChange.send()
        }
    }
    
    init() {
        for i in 1...10 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                self.value += 1
            }
        }
    }
}

struct ObectChangeView: View {
    
    @ObservedObject var updater = DelayedUpdater()
    
    var body: some View {
        Text("Value is \(updater.value)")
    }
}

struct ObectChangeView_Previews: PreviewProvider {
    static var previews: some View {
        ObectChangeView()
    }
}
