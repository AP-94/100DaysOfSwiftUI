//
//  HideShowViews.swift
//  iExpense
//
//  Created by Alessandro Pace on 29/4/21.
//

import SwiftUI

struct SecondView: View {
    var name = ""
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("SHEET -- Hello \(name)!")
            Button("Dimiss") {
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct HideShowView: View {
    @State private var showingSheet = false
    
    var body: some View {
        Button("Action Sheet") {
            self.showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet) {
            SecondView(name: "Alessandro")
        }
    }
}

struct HideShowView_Previews: PreviewProvider {
    static var previews: some View {
        HideShowView()
    }
}
