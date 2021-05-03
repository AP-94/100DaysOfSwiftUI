//
//  ContentView.swift
//  iExpense
//
//  Created by Alessandro Pace on 29/4/21.
//

class User: ObservableObject {
    @Published var firstName = "Bilbo"
    @Published var lastName = "Baggins"
}

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var user = User()
    
    var body: some View {
        VStack {
                    Text("Your name is \(user.firstName) \(user.lastName).")

                    TextField("First name", text: $user.firstName)
                    TextField("Last name", text: $user.lastName)
                }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
