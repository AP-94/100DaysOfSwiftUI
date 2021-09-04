//
//  OptionalSheetAlertView.swift
//  OptionalSheetAlertView
//
//  Created by Alessandro Pace on 23/8/21.
//

import SwiftUI

struct User: Identifiable {
    var id = "Taylor Swift"
}

struct OptionalSheetAlertView: View {
    @State private var selectedUser: User? = nil
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onTapGesture {
                selectedUser = User()
            }
            .alert(item: $selectedUser) { user in
                Alert(title: Text(user.id))
            }
    }
}

struct OptionalSheetAlertView_Previews: PreviewProvider {
    static var previews: some View {
        OptionalSheetAlertView()
    }
}
