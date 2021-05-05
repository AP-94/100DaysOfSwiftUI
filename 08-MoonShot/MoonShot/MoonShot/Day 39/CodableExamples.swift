//
//  CodableExamples.swift
//  MoonShot
//
//  Created by Alessandro Pace on 3/5/21.
//

import SwiftUI

struct User: Codable {
    var name: String
    var address: Address
}

struct Address: Codable {
    var street: String
    var city: String
}

struct CodableExamples: View {
    var body: some View {
        Button("Decode JSON") {
            let input = """
    {
        "name": "Taylor Swift",
        "address": {
            "street": "555, Taylor Swift Avenue",
            "city": "Nashville"
        }
    }
    """
            
            let data = Data(input.utf8)
            let decoder = JSONDecoder()
            
            if let user = try? decoder.decode(User.self, from: data) {
                print(user.address.street)
            }
        }
    }
}

struct CodableExamples_Previews: PreviewProvider {
    static var previews: some View {
        CodableExamples()
    }
}
