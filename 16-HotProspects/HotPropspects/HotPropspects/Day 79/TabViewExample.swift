//
//  TabView.swift
//  TabView
//
//  Created by Alessandro Pace on 31/7/21.
//

import SwiftUI

struct TabViewExample: View {
    
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Text("TAB 1")
                .onTapGesture {
                    selectedTab = 1
                }
                .tabItem {
                    Image(systemName: "star")
                    Text("One")
                }
                .tag(1)
            Text("TAB 2")
                .onTapGesture {
                    selectedTab = 2
                }
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Two")
                }
                .tag(2)
        }
    }
}

struct TabViewExample_Previews: PreviewProvider {
    static var previews: some View {
        TabViewExample()
    }
}
