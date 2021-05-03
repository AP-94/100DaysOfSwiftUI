//
//  UserDefaultsView.swift
//  iExpense
//
//  Created by Alessandro Pace on 29/4/21.
//

import SwiftUI

struct UserDefaultsView: View {
    @State private var tapCount =  UserDefaults.standard.integer(forKey: "Tap")

        var body: some View {
            Button("Tap count: \(tapCount)") {
                self.tapCount += 1
                UserDefaults.standard.set(self.tapCount, forKey: "Tap")
            }
        }
}

struct UserDefaultsView_Previews: PreviewProvider {
    static var previews: some View {
        UserDefaultsView()
    }
}
