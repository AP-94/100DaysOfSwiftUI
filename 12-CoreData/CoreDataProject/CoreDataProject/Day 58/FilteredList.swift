//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Alessandro Pace on 15/6/21.
//

import SwiftUI
import CoreData

//CHALLENGE 3 PREDICATES ENUM
enum Predicates: String {
    case beginsWith = "BEGINSWITH"
    case endsWith = "ENDSWITH"
    case equals = "=="
    case contains = "CONTAINS"
    case like = "LIKE"
    case matches = "MATCHES"
    case beginsWithIgnoreCase = "BEGINSWITH[c]"
    case endsWithIgnoreCase = "ENDSWITH[c]"
    case containsIgnoreCase = "CONTAINS[c]"
    case likeIgnoreCase = "LIKE[c]"
    
}

struct FilteredList<T: NSManagedObject, Content: View>: View {
    var fetchRequest: FetchRequest<T>
    var objects: FetchedResults<T> { fetchRequest.wrappedValue }
    let content: (T) -> Content
    
    var body: some View {
        List(objects, id: \.self) { object in
            self.content(object)
        }
    }
    
    //CHALLENGES 1,2 & 3 INIT REWRITE
    
    init(sortDescriptorArray: [NSSortDescriptor], filterKey: String, predicate: Predicates, filterValue: String, @ViewBuilder content: @escaping (T) -> Content) {
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: sortDescriptorArray, predicate: NSPredicate(format: "%K \(predicate.rawValue) %@", filterKey, filterValue))
        self.content = content
    }
}

