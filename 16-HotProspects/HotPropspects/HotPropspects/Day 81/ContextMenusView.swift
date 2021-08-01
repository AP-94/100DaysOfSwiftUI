//
//  ContextMenusView.swift
//  ContextMenusView
//
//  Created by Alessandro Pace on 31/7/21.
//

import SwiftUI

struct ContextMenusView: View {
    
    @State private var backgroundColor = Color.red
    
    var body: some View {
        VStack {
            Text("Hello, World")
                .padding()
                .background(backgroundColor)
            
            Text("Change Color")
                .padding()
                .contextMenu {
                    Button {
                        backgroundColor = .red
                    } label: {
                        Text("Red")
                        Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.red)
                    }
                    
                    Button {
                        backgroundColor = .yellow
                    } label: {
                        Text("Yellow")
                    }
                    
                    Button {
                        backgroundColor = .blue
                    } label: {
                        Text("Blue")
                    }

                }
        }
    }
}

struct ContextMenusView_Previews: PreviewProvider {
    static var previews: some View {
        ContextMenusView()
    }
}
