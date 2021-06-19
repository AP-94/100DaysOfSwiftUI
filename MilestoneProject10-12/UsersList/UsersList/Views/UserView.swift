//
//  UserView.swift
//  UsersList
//
//  Created by Alessandro Pace on 17/6/21.
//

import SwiftUI

struct UserView: View {
    
    let user: User
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(user.wrappedName)
                    .font(.headline)
                
                Spacer()
                HStack {
                    Text("State")
                        .fontWeight(.semibold)
                    Circle()
                        .foregroundColor(user.isActive ? .green : .gray)
                        .frame(width: 10, height: 10, alignment: .topLeading)
                }
            }
            HStack {
                Text("Email:")
                    .font(.subheadline)
                Text(user.wrappedEmail)
                    .font(.body)
            }
            HStack {
                Text("Company:")
                    .font(.subheadline)
                Text(user.wrappedCompanty)
                    .font(.body)
            }
        }
        .padding()
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(user: User())
//        UserView(user: UserModel(id: "1", isActive: true, name: "Alessandro Pace", age: 26, company: "BeMobile", email: "email@gmail.com", address: "1st Main, Two doors 20933", about: "Occaecat consequat elit aliquip magna laboris dolore laboris sunt officia adipisicing reprehenderit sunt. Do in proident consectetur labore. Laboris pariatur quis incididunt nostrud labore ad cillum veniam ipsum ullamco. Dolore laborum commodo veniam nisi. Eu ullamco cillum ex nostrud fugiat eu consequat enim cupidatat. Non incididunt fugiat cupidatat reprehenderit nostrud eiusmod eu sit minim do amet qui cupidatat. Elit aliquip nisi ea veniam proident dolore exercitation irure est deserunt.\r\n", registered: "", tags: ["cillum","test","lorem","spart","ssiql"], friends: [FriendModel(id: "22", name: "John Cena")]))
    }
}
