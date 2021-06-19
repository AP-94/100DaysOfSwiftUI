//
//  User+CoreDataProperties.swift
//  UsersList
//
//  Created by Alessandro Pace on 19/6/21.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var about: String?
    @NSManaged public var address: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var id: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var registered: String?
    @NSManaged public var name: String?
    @NSManaged public var friends: NSSet?
    @NSManaged public var tags: NSSet?

    public var wrappedId: String {
        id ?? "Unknown ID"
    }
    
    public var wrappedName: String {
        name ?? "Unknown Name"
    }
    
    public var wrappedCompanty: String {
        company ?? "Unknown company"
    }
    
    public var wrappedEmail: String {
        email ?? "Unknown email"
    }
    
    public var wrappedAddress: String {
        address ?? "Unknown address"
    }
    
    public var wrappedAbout: String {
        about ?? "Unknown about"
    }
    
    public var friendsArray : [Friend] {
        let friendsSet = friends as? Set<Friend> ?? []
        
        return friendsSet.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
    
    public var tagsArray : [Tag] {
        let tagsSet = tags as? Set<Tag> ?? []
        
        return tagsSet.sorted {
            $0.wrappedTag < $1.wrappedTag
        }
    }
    
}

// MARK: Generated accessors for friends
extension User {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: Friend)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: Friend)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

}

// MARK: Generated accessors for tags
extension User {

    @objc(addTagsObject:)
    @NSManaged public func addToTags(_ value: Tag)

    @objc(removeTagsObject:)
    @NSManaged public func removeFromTags(_ value: Tag)

    @objc(addTags:)
    @NSManaged public func addToTags(_ values: NSSet)

    @objc(removeTags:)
    @NSManaged public func removeFromTags(_ values: NSSet)

}

extension User : Identifiable {

}
