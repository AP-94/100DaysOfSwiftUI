////
////  Order.swift
////  CupcakeCorner
////
////  Created by Alessandro Pace on 24/5/21.
////
//
//import Foundation
//
//enum Type: String, Equatable, CaseIterable {
//    case vanilla = "Vanilla"
//    case strawberry = "Strawberry"
//    case chocolate = "Chocolate"
//    case rainbow = "Rainbow"
//}
//
//class OldOrder: ObservableObject, Codable {
//
//    init() {}
//
//    @Published var type: Type = .vanilla
//    @Published var quantity = 3
//    @Published var extraFrosting = false
//    @Published var addSprinkles = false
//    @Published var name = ""
//    @Published var streetAddress = ""
//    @Published var city = ""
//    @Published var zip = ""
//    @Published var specialRequestEnabled = false {
//        didSet {
//            if specialRequestEnabled == false {
//                extraFrosting = false
//                addSprinkles = false
//            }
//        }
//    }
//
//    var hasValidAddress: Bool {
//        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty || zip.isEmpty {
//            return false
//        }
//
//        //Challenge 1
//        if name.isBlank || streetAddress.isBlank || city.isBlank || zip.isBlank || zip.isBlank {
//            return false
//        }
//
//        return true
//    }
//
//    var cost: Double {
//        // $2 per cake
//        var cost = Double(quantity) * 2
//
//        cost += Double(type.index ?? 0) / 2
//
//        if extraFrosting {
//            cost += Double(quantity)
//        }
//
//        if addSprinkles {
//            cost += Double(quantity) / 2
//        }
//
//        return cost
//    }
//
//    //Needed to make this class Codable
//
//    enum CodingKeys: CodingKey {
//        case type, quantity, extraFrosting, addSprinkles, name, streetAddress, city, zip
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//
//        try container.encode(type.rawValue, forKey: .type)
//        try container.encode(quantity, forKey: .quantity)
//        try container.encode(extraFrosting, forKey: .extraFrosting)
//        try container.encode(addSprinkles, forKey: .addSprinkles)
//        try container.encode(name, forKey: .name)
//        try container.encode(streetAddress, forKey: .streetAddress)
//        try container.encode(city, forKey: .city)
//        try container.encode(zip, forKey: .zip)
//    }
//
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//        type = Type(rawValue: try container.decode(String.self, forKey: .type)) ?? .vanilla
//        quantity = try container.decode(Int.self, forKey: .quantity)
//
//        extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
//        addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
//
//        name = try container.decode(String.self, forKey: .name)
//        streetAddress = try container.decode(String.self, forKey: .streetAddress)
//        city = try container.decode(String.self, forKey: .city)
//        zip = try container.decode(String.self, forKey: .zip)
//    }
//}
//
//extension CaseIterable where Self: Equatable {
//
//    var index: Self.AllCases.Index? {
//        return Self.allCases.firstIndex { self == $0 }
//    }
//}
//
//extension String {
//    var isBlank: Bool {
//        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
//    }
//}
