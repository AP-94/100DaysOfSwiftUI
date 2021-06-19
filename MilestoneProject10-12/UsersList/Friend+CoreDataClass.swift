//
//  Friend+CoreDataClass.swift
//  UsersList
//
//  Created by Alessandro Pace on 19/6/21.
//
//

import Foundation
import CoreData

@objc(Friend)
public class Friend: NSManagedObject, Decodable {
    
    enum CodingKeys: CodingKey {
        case id, name
    }
    
    required convenience public init(from decoder: Decoder) throws {

            guard let context = decoder.userInfo[.context] as? NSManagedObjectContext else {
                fatalError("NSManagedObjectContext is missing")
            }

            self.init(context: context)
            let container = try decoder.container(keyedBy: CodingKeys.self)

            id = try container.decode(String.self, forKey: .id)
            name = try container.decode(String.self, forKey: .name)

        }

}
