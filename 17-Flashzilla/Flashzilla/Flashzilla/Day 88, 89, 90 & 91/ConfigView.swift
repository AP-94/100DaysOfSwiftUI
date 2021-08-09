//
//  ConfigView.swift
//  ConfigView
//
//  Created by Alessandro Pace on 9/8/21.
//

import SwiftUI

struct ConfigView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var wrongCardToogle: Bool
    
    var body: some View {
        NavigationView {
            Form {
                Toggle("Wrong cards go back to stack", isOn: $wrongCardToogle)
            }
            
            .navigationTitle("Configuration")
            .navigationBarItems(trailing: Button("Done", action: dismiss))
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}
