//
//  UserModel.swift
//  UsersList
//
//  Created by Alessandro Pace on 17/6/21.
//

import Foundation

struct UserModel: Codable, Hashable, Identifiable {
    static func == (lhs: UserModel, rhs: UserModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id: String
    var isActive: Bool?
    var name: String?
    var age: Int?
    var company: String?
    var email: String?
    var address: String?
    var about: String?
    var registered: String?
    var tags: [String]?
    var friends: [FriendModel]?
    
    enum CodingKeys: CodingKey {
        case id, isActive, name, age, company, email, address, about, registered, tags, friends
    }
}
