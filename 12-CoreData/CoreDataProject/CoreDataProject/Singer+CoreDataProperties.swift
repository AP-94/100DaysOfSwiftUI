//
//  Singer+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Alessandro Pace on 15/6/21.
//
//

import Foundation
import CoreData


extension Singer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Singer> {
        return NSFetchRequest<Singer>(entityName: "Singer")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?

    var wrappedFirstName: String {
        return firstName ?? "Unknown"
    }
    
    var wrappedLastName: String {
        return lastName ?? "Unknown"
    }
}

extension Singer : Identifiable {

}
