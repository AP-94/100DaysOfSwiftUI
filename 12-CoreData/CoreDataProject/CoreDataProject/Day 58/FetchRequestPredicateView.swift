//
//  FetchRequestPredicateView.swift
//  CoreDataProject
//
//  Created by Alessandro Pace on 14/6/21.
//

import SwiftUI
import CoreData

struct FetchRequestPredicateView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Ship.entity(), sortDescriptors: [], predicate: NSPredicate(format: "universe in %@", ["Halo", "Aliens", "Star Wars"])) var ships: FetchedResults<Ship>
    
    var body: some View {
        VStack {
            List(ships, id: \.self) { ship in
                Text(ship.name ?? "Unkown name")
            }
            
            Button("Add ship examples") {
                let ship1 = Ship(context: self.moc)
                ship1.name = "Enterprise"
                ship1.universe = "Star Trek"
                
                let ship2 = Ship(context: self.moc)
                ship2.name = "Millenium Falcon"
                ship2.universe = "Star Wars"
                
                let ship3 = Ship(context: self.moc)
                ship3.name = "Defiant"
                ship3.universe = "Star Trek"
                
                let ship4 = Ship(context: self.moc)
                ship4.name = "Infinite"
                ship4.universe = "Halo"
                
                try? self.moc.save()
            }
        }
    }
}

struct FetchRequestPredicateView_Previews: PreviewProvider {
    static var previews: some View {
        FetchRequestPredicateView()
    }
}
