//
//  User+CoreDataClass.swift
//  UsersList
//
//  Created by Alessandro Pace on 19/6/21.
//
//

import Foundation
import CoreData

@objc(User)
public class User: NSManagedObject, Decodable {
    
    enum CodingKeys: CodingKey {
        case id, isActive, name, age, company, email, address, about, registered, tags, friends
    }
    
    required convenience public init(from decoder: Decoder) throws {

            guard let context = decoder.userInfo[.context] as? NSManagedObjectContext else {
                fatalError("NSManagedObjectContext is missing")
            }

            self.init(context: context)

            let container = try decoder.container(keyedBy: CodingKeys.self)

            id = try container.decode(String.self, forKey: .id)
            isActive = try container.decode(Bool.self, forKey: .isActive)
            name = try container.decode(String.self, forKey: .name)
            age = try container.decode(Int16.self, forKey: .age)
            company = try container.decode(String.self, forKey: .company)
            email = try container.decode(String.self, forKey: .email)
            address = try container.decode(String.self, forKey: .address)
            about = try container.decode(String.self, forKey: .about)
            registered = try container.decode(String.self, forKey: .registered)

            //let tagsSet = try container.decode(Set<Tag>.self, forKey: .tags)
            //tags = tags as NSSet

            let friendsSet = try container.decode(Set<Friend>.self, forKey: .friends)
            friends = friendsSet as NSSet

        }

}

extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "context")!
}

extension JSONDecoder {
    convenience init(context: NSManagedObjectContext) {
        self.init()
        self.userInfo[.context] = context
    }
}
