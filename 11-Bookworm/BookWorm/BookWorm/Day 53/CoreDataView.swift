//
//  CoreDataView.swift
//  BookWorm
//
//  Created by Alessandro Pace on 2/6/21.
//

import SwiftUI

struct CoreDataView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Student.entity(), sortDescriptors: []) var students: FetchedResults<Student>
    
    var body: some View {
        VStack {
            List {
                ForEach(students, id: \.id) { student in
                    Text(student.name ?? "Not known")
                }
            }
            
            Button("Add"){
                let firstNames = ["Ginny", "Harry", "Hermione", "Luna", "Ron"]
                let lastNames = ["Granger", "Lovegood","Potter", "Weasley"]
                
                let choosenFirstName = firstNames.randomElement()!
                let choosenLastName = lastNames.randomElement()!
                
                let student = Student(context: self.moc)
                student.id = UUID()
                student.name = choosenFirstName + " " + choosenLastName
                
                try? self.moc.save()
                
            }
        }
    }
}

struct CoreDataView_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataView()
    }
}
