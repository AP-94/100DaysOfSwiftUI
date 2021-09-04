//
//  GroupTransparentView.swift
//  GroupTransparentView
//
//  Created by Alessandro Pace on 23/8/21.
//

import SwiftUI

struct UserView: View {
    
    var body: some View {
        Group {
            Text("Name: Paul Hudson")
            Text("Country: England")
            Text("Pets: Luna, Arya, and Toby")
        }
    }
}

struct GroupTransparentView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        Group {
            if sizeClass == .compact {
                VStack {
                    UserView()
                }
            } else {
                ///This is a way to create a short HStack with less code
                HStack(content: UserView.init)
            }
        }
    }
}

struct GroupTransparentView_Previews: PreviewProvider {
    static var previews: some View {
        GroupTransparentView()
    }
}
