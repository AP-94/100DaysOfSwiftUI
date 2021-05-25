//
//  Order.swift
//  CupcakeCorner
//
//  Created by Alessandro Pace on 24/5/21.
//

import Foundation

enum Type: String, Equatable, CaseIterable, Codable {
    case vanilla = "Vanilla"
    case strawberry = "Strawberry"
    case chocolate = "Chocolate"
    case rainbow = "Rainbow"
}

class ObservedOrder: ObservableObject {
    @Published var order: Order

    init(order: Order) {
        self.order = order
    }
}

//Challenge 3 Change order from class to struct
struct Order: Codable {
    
    var type: Type = .vanilla
    var quantity = 3
    var extraFrosting = false
    var addSprinkles = false
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    
    var hasValidAddress: Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty || zip.isEmpty {
            return false
        }
        
        //Challenge 1
        if name.isBlank || streetAddress.isBlank || city.isBlank || zip.isBlank || zip.isBlank {
            return false
        }
        
        return true
    }
    
    var cost: Double {
        // $2 per cake
        var cost = Double(quantity) * 2
        
        cost += Double(type.index ?? 0) / 2
        
        if extraFrosting {
            cost += Double(quantity)
        }
        
        if addSprinkles {
            cost += Double(quantity) / 2
        }
        
        return cost
    }
    
    //Needed to make this class Codable
    
    enum CodingKeys: CodingKey {
        case type, quantity, extraFrosting, addSprinkles, name, streetAddress, city, zip
    }

}

extension CaseIterable where Self: Equatable {

    var index: Self.AllCases.Index? {
        return Self.allCases.firstIndex { self == $0 }
    }
}

extension String {
    var isBlank: Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
