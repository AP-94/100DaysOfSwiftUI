//
//  ObservedUsers.swift
//  UsersList
//
//  Created by Alessandro Pace on 19/6/21.
//

import Foundation

class ObservedUsers: ObservableObject {
    @Published var users: [UserModel] = []
    
    init() {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("* * * * * * * * INVALID URL * * * * * * * *")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode([UserModel].self, from: data) {
                    
                    DispatchQueue.main.async {
                        self.users = decodedResponse
                    }
                    
                    return
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
    
    func fetchUserWithID(_ userId: String) -> UserModel? {
        return users.first { $0.id == userId }
    }
}
