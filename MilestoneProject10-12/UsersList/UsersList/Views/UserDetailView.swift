//
//  UserDetailView.swift
//  UsersList
//
//  Created by Alessandro Pace on 19/6/21.
//

import SwiftUI

struct InfoView: View {
    let title: String
    let info: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
            Text(info)
        }
    }
}

struct UserDetailView: View {
    
    let user: User
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: User.entity(), sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)]) var users: FetchedResults<User>
    //@ObservedObject var observedUsers: ObservedUsers
    
    var body: some View {
        Form {
            Section(header: Text("User Info")) {
                InfoView(title: "Name:", info: user.wrappedName)
                InfoView(title: "Age:", info: String(user.age))
                InfoView(title: "Email:", info: user.wrappedEmail)
                InfoView(title: "Company:", info: user.wrappedCompanty)
                InfoView(title: "Address:", info: user.wrappedAddress)
                InfoView(title: "User active:", info: "\(user.isActive)")
            }
            
            Section(header: Text("Friends")) {
                ForEach(user.friendsArray, id: \.self) { friend in
                    if let friendFound = getFriendUserWithID(friend.wrappedId) {
                        NavigationLink(destination: UserDetailView(user: friendFound) ) {
                            Text(friendFound.wrappedName)
                        }
                    }
                }
            }
            
            Section(header: Text("About")) {
                InfoView(title: "", info: user.wrappedAbout)
            }
            
            Section(header: Text("Tags")) {
                ForEach(user.tagsArray, id: \.self) { tag in
                    Text(tag.wrappedTag)
                        .font(.headline)
                }
            }
            
            
        }
        .navigationBarTitle(user.name ?? "")
    }
    
    func getFriendUserWithID(_ userID: String) -> User? {
        return users.first { $0.id == userID }
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailView(user: User())
//        UserDetailView(user: UserModel(id: "1", isActive: true, name: "Alessandro Pace", age: 26, company: "BeMobile", email: "email@gmail.com", address: "1st Main, Two doors 20933", about: "Occaecat consequat elit aliquip magna laboris dolore laboris sunt officia adipisicing reprehenderit sunt. Do in proident consectetur labore. Laboris pariatur quis incididunt nostrud labore ad cillum veniam ipsum ullamco. Dolore laborum commodo veniam nisi. Eu ullamco cillum ex nostrud fugiat eu consequat enim cupidatat. Non incididunt fugiat cupidatat reprehenderit nostrud eiusmod eu sit minim do amet qui cupidatat. Elit aliquip nisi ea veniam proident dolore exercitation irure est deserunt.\r\n", registered: "", tags: ["cillum","test","lorem","spart","ssiql"], friends: [FriendModel(id: "22", name: "John Cena")]), observedUsers: ObservedUsers())
    }
}
