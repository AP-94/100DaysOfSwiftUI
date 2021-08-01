//
//  Prospect.swift
//  Prospect
//
//  Created by Alessandro Pace on 31/7/21.
//

import SwiftUI

class Prospect: Identifiable, Codable {
    var id = UUID()
    var timestamp = Date()
    var name = "Anonymous"
    var emailAddress = ""
    fileprivate(set) var isContacted = false
}

class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]
    static let saveKey = "SavedData"
    
    //Challenge 2 key json
    static let jsonKey = "savedData.json"

    init() {
//        if let data = UserDefaults.standard.data(forKey: Self.saveKey) {
//            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
//                self.people = decoded
//                return
//            }
//        }
        
        //Challegene 2 Use Documents directory to save and retrieve data
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(Self.jsonKey)
        
        if (try? Data(contentsOf: url)) != nil {
            self.people = FileManager.default.decode(Self.jsonKey)
        } else {
            self.people = []
        }
        
    }
    
    private func save() {
//        if let encoded = try? JSONEncoder().encode(people) {
//            UserDefaults.standard.set(encoded, forKey: Self.saveKey)
//        }
        
        //Challenge 2 encode to documents directory
        FileManager.default.encode(people, Self.jsonKey)
    }
    
    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }
    
    func toogle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
    
    //Challenge 3 Sort
    func sortByNames() {
        self.people = people.sorted { prospect1, prospect2 in
            prospect1.name < prospect2.name
        }
    }
    
    //Challenge 3 Sort
    func sortByMostRecent() {
        self.people = people.sorted { prospect1, prospect2 in
            prospect1.timestamp > prospect2.timestamp
        }
    }
}
