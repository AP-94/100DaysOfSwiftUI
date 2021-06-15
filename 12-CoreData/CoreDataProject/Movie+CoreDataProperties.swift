//
//  Movie+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Alessandro Pace on 14/6/21.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var title: String?
    @NSManaged public var year: Int16
    @NSManaged public var director: String?
    
    public var wrappedTitle: String {
        return title ?? "Unknown title"
    }
    
    public var wrappedDirector: String {
        return director ?? "Unknown director"
    }
    
    public var wrappedYear: String {
        return String(year)
    }

}

extension Movie : Identifiable {

}
