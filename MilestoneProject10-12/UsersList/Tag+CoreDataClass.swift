//
//  Tag+CoreDataClass.swift
//  UsersList
//
//  Created by Alessandro Pace on 19/6/21.
//
//

import Foundation
import CoreData

@objc(Tag)
public class Tag: NSManagedObject, Decodable {
    
    required convenience public init(from decoder: Decoder) throws {

            guard let context = decoder.userInfo[.context] as? NSManagedObjectContext else {
                fatalError("NSManagedObjectContext is missing")
            }

            self.init(context: context)

        }

}
