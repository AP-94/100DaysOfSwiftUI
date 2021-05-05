//
//  ContentView.swift
//  MoonShot
//
//  Created by Alessandro Pace on 3/5/21.
//

import SwiftUI

struct GeometryReaderView: View {
    var body: some View {
        VStack {
            GeometryReader { geo in
                Image("wallpaper")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geo.size.width)
            }
        }
    }
}

struct GeometryReaderView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReaderView()
    }
}
