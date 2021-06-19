//
//  ContentView.swift
//  UsersList
//
//  Created by Alessandro Pace on 17/6/21.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var observedUsers = ObservedUsers()
    
    var body: some View {
        NavigationView {
            List(observedUsers.users, id: \.self) { user in
                NavigationLink(destination: UserDetailView(user: user, observedUsers: observedUsers)) {
                    UserView(user: user)
                }
            }.navigationBarTitle("Users List")
        }
    }
    
    func getUserFriends() -> [UserModel] {
        return []
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
