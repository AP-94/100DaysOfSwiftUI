//
//  Favorites.swift
//  Favorites
//
//  Created by Alessandro Pace on 4/9/21.
//

import SwiftUI

class Favorites: ObservableObject {
    //CHALLENGE 2 SAVE FAVORITES
    static let favoriteResorts = "favoritesResorts.json"
    private var resorts: Set<String>
    
    private let saveKey = "Favorites"
    
    init() {
        //CHALLENGE 2 SAVE FAVORITES
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(Favorites.favoriteResorts)
        
        if (try? Data(contentsOf: url)) != nil {
            resorts = FileManager.default.decode(Favorites.favoriteResorts)
        } else {
            resorts = []
        }
        
    }
    
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }
    
    private func save() {
        //CHALLENGE 2 SAVE FAVORITES
        FileManager.default.encode(resorts, Favorites.favoriteResorts)
    }
}
