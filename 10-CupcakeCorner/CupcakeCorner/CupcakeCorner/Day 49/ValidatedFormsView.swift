//
//  ValidatedFormsView.swift
//  CupcakeCorner
//
//  Created by Alessandro Pace on 24/5/21.
//

import SwiftUI

struct ValidatedFormsView: View {
    
    @State var username = ""
    @State var email = ""
    
    var disableForm: Bool {
        username.count < 5 || email.count < 5
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }
            Section {
                Button("Create account") {
                    print("Creating account...")
                }
            }
            .disabled(disableForm)
        }
    }
}

struct ValidatedFormsView_Previews: PreviewProvider {
    static var previews: some View {
        ValidatedFormsView()
    }
}
