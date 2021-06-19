//
//  ContentView.swift
//  UsersList
//
//  Created by Alessandro Pace on 17/6/21.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var observedUsers = ObservedUsers()
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: User.entity(), sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)]) var users: FetchedResults<User>
    
    
    var body: some View {
        NavigationView {
            List(users, id: \.self) { user in
                NavigationLink(destination: UserDetailView(user: user)) {
                    UserView(user: user)
                }
            }.navigationBarTitle("Users List")
        }.onAppear(perform: getUsers)
    }
    
    func getUsers() {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("* * * * * * * * INVALID URL * * * * * * * *")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode([UserModel].self, from: data) {
                    
                    DispatchQueue.main.async {
                        for user in decodedResponse {
                            let newUser = User(context: moc)
                            newUser.id = user.id
                            newUser.name = user.name
                            newUser.about = user.about
                            newUser.address = user.address
                            newUser.isActive = user.isActive ?? false
                            newUser.registered = user.registered
                            newUser.age = Int16(user.age ?? 0)
                            newUser.company = user.company
                            newUser.email = user.email
                            
                            for friend in user.friends ?? [] {
                                let newFriend = Friend(context: self.moc)
                                newFriend.id = friend.id
                                newFriend.name = friend.name
                                newUser.addToFriends(newFriend)
                            }
                            
                            for tag in user.tags ?? [] {
                                let newTag = Tag(context: moc)
                                newTag.tag = tag
                                newUser.addToTags(newTag)
                            }
                            
                        }
                        
                        do {
                            try self.moc.save()
                        } catch {
                            print("Error saving to core data: \(error.localizedDescription)")
                        }
                    }
                    
                    return
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
