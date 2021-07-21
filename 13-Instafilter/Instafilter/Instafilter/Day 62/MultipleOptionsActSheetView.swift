//
//  MultipleOptionsActSheetView.swift
//  Instafilter
//
//  Created by Alessandro Pace on 28/6/21.
//

import SwiftUI

struct MultipleOptionsActSheetView: View {
    
    @State private var showingActionSheet = false
    @State private var backgroundColor = Color.white
    
    var body: some View {
        
        Text("Text")
            .frame(width: 300, height: 300)
            .background(backgroundColor)
            .onTapGesture {
                self.showingActionSheet = true
            }
            .actionSheet(isPresented: $showingActionSheet) {
                ActionSheet(title: Text("Change color of background"), message: Text("Select new color"), buttons: [
                    .default(Text("Red")) { backgroundColor = .red },
                    .default(Text("Green")) { backgroundColor = .green },
                    .default(Text("Blue")) { backgroundColor = .blue },
                    .cancel() { backgroundColor = .white }
                ])
            }
        
    }
    
}

struct MultipleOptionsActSheetView_Previews: PreviewProvider {
    static var previews: some View {
        MultipleOptionsActSheetView()
    }
}
