//
//  ContentView.swift
//  HotPropspects
//
//  Created by Alessandro Pace on 31/7/21.
//

import SwiftUI

class User: ObservableObject {
    @Published var name = "Taylor Swift"
}

struct EditView: View {
    @EnvironmentObject var user: User
    
    
    var body: some View {
        TextField("Name", text: $user.name)
    }
}

struct DisplayView: View {
    @EnvironmentObject var user: User
    
    var body: some View {
        Text(user.name)
    }
}

struct ContentView: View {
    let user = User()
    
    var body: some View {
        VStack {
            EditView()//.environmentObject(user)
            DisplayView()//.environmentObject(user)
        }
        .environmentObject(user)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
