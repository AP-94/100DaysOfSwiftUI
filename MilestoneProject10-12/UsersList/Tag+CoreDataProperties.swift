//
//  Tag+CoreDataProperties.swift
//  UsersList
//
//  Created by Alessandro Pace on 19/6/21.
//
//

import Foundation
import CoreData


extension Tag {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tag> {
        return NSFetchRequest<Tag>(entityName: "Tag")
    }

    @NSManaged public var tag: String?
    @NSManaged public var user: User?

    public var wrappedTag: String {
        tag ?? "Unknown ID"
    }
}

extension Tag : Identifiable {

}
