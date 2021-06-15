//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Alessandro Pace on 14/6/21.
//

import SwiftUI

struct Student: Hashable {
    let name: String
}

struct ContentView: View {
    
    let students = [Student(name: "Master Chief"), Student(name: "Cortana")]

    var body: some View {
        List(students, id: \.self) { student in
            Text(student.name)
//            ForEach([2,4,6,8,10], id: \.self) {
//                Text("\($0) is even")
//            }
        }
    }

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
