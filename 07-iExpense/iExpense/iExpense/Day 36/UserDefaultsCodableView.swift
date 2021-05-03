//
//  UserDefaultsCodableView.swift
//  iExpense
//
//  Created by Alessandro Pace on 29/4/21.
//

import SwiftUI

struct UserModel: Codable {
    var firstName: String
    var lastName: String
}

struct UserDefaultsCodableView: View {
    
    @State private var user = UserModel(firstName: "Taylor", lastName: "Swift")
    
    var body: some View {
        Button("Presioname para guardar tu info") {
            let encoder = JSONEncoder()
            
            if let data = try? encoder.encode(user) {
                UserDefaults.standard.setValue(data, forKey: "User")
            }
        }
    }
}

struct UserDefaultsCodableView_Previews: PreviewProvider {
    static var previews: some View {
        UserDefaultsCodableView()
    }
}
