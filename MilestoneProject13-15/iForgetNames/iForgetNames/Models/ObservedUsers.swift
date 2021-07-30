//
//  ObservedUsers.swift
//  iForgetNames
//
//  Created by Alessandro Pace on 28/7/21.
//

import Foundation

class ObservedUsers: ObservableObject {
    static let usersDocument = "usersDocument.json"
    @Published var users: [User] = []
    
    init() {
        getUsersFromDocumentsDirectory()
    }
    
    func saveUsersToDocumentsDirectory() {
        FileManager.default.encode(users, ObservedUsers.usersDocument)
    }
    
    private func getUsersFromDocumentsDirectory() {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(ObservedUsers.usersDocument)
        guard (try? Data(contentsOf: url)) != nil else { return }
        users = FileManager.default.decode(ObservedUsers.usersDocument)
    }
}
