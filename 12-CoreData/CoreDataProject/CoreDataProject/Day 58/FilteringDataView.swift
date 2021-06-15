//
//  FilteringDataView.swift
//  CoreDataProject
//
//  Created by Alessandro Pace on 15/6/21.
//

import SwiftUI

struct FilteringDataView: View {
    @Environment(\.managedObjectContext) var moc
    @State var lastNameFilter = "A"
    
    var body: some View {
        VStack {
            FilteredList(sortDescriptorArray: [], filterKey: "lastName", predicate: .beginsWith, filterValue: lastNameFilter) { (singer: Singer) in
                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
            }
            
            Button("Add examples") {
                let taylor = Singer(context: moc)
                taylor.firstName = "Taylor"
                taylor.lastName = "Swift"
                
                let ed = Singer(context: moc)
                ed.firstName = "Ed"
                ed.lastName = "Sheeran"
                
                let adele = Singer(context: moc)
                adele.firstName = "Adele"
                adele.lastName = "Adkins"
                
                try? moc.save()
                
            }
            
            HStack {
                Button("Show A") {
                    self.lastNameFilter = "A"
                }
                
                Button("Show S") {
                    self.lastNameFilter = "S"
                }
            }
            
        }
    }
}

struct FilteringDataView_Previews: PreviewProvider {
    static var previews: some View {
        FilteringDataView()
    }
}
