//
//  ContentView.swift
//  WordScramble
//
//  Created by Alessandro Pace on 17/2/21.
//

import SwiftUI

struct ListExample: View {
    let people = ["Robert", "Anna", "Giovanni", "Caroline", "Scar"]
    
    
    var body: some View {
//        List {
//            Section (header: Text("Section 1") ) {
//                Text("Static Hello World")
//                Text("Static Hello World")
//                Text("Static Hello World")
//            }
//
//            Section (header: Text("Section 2") ) {
//                ForEach(0..<5) {
//                    Text("Dynamic \($0) Hello World")
//                }
//            }
//
//            Section (header: Text("Section 3") ) {
//                Text("Static Hello World")
//                Text("Static Hello World")
//                Text("Static Hello World")
//            }
//        }
//        .listStyle(GroupedListStyle())
        
        
        //Dynimic list with foreach integrated
//        List(0..<20) {
//            Text("Dynamic row \($0)")
//
//        }
//        .listStyle(GroupedListStyle())
        
        
        //Dynimaci List with \.self
        List (people, id: \.self) {
                Text("Dynamic row name: \($0)")
        }
        .listStyle(GroupedListStyle())
    }
}

struct ListExample_Previews: PreviewProvider {
    static var previews: some View {
        ListExample()
    }
}
