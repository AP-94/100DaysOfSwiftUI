//
//  FriendModel.swift
//  UsersList
//
//  Created by Alessandro Pace on 17/6/21.
//

import Foundation

struct FriendModel: Codable, Hashable {
    var id: String
    var name: String
    
    enum CodingKeys: CodingKey {
        case id, name
    }
}
