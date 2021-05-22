//
//  ActivityModel.swift
//  HabitsApp
//
//  Created by Alessandro Pace on 18/5/21.
//

import Foundation

struct Activity: Identifiable, Codable {
    var id = UUID()
    var title: String
    var description: String
    var completitionCount: Int
}
