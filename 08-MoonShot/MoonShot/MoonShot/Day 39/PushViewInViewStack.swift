//
//  PushViewInViewStack.swift
//  MoonShot
//
//  Created by Alessandro Pace on 3/5/21.
//

import SwiftUI

struct PushViewInViewStack: View {
    
    var body: some View {
        NavigationView {
            List(0..<100) { row in
                NavigationLink(
                    destination: Text("Detail of row number \(row)"),
                    label: {
                        Text("\(row) -- Go to detail")
                    })
            }
            .navigationBarTitle("SwiftUI")
        }
    }
    
}

struct PushViewInViewStack_Previews: PreviewProvider {
    static var previews: some View {
        PushViewInViewStack()
    }
}
