//
//  ContentView.swift
//  DiceRoller
//
//  Created by Alessandro Pace on 12/8/21.
//

import SwiftUI

struct TabsView: View {
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            ResultsView()
                .tabItem {
                    Image(systemName: "text.badge.checkmark")
                    Text("Results")
                }
        }
    }
    
}

struct TabsView_Previews: PreviewProvider {
    static var previews: some View {
        TabsView()
    }
}
