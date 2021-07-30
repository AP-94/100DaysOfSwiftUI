//
//  UserDetailView.swift
//  iForgetNames
//
//  Created by Alessandro Pace on 28/7/21.
//

import MapKit
import SwiftUI

struct UserDetailView: View {
    
    let user: User
    @State private var image: Image?
    
    var body: some View {
        VStack {
            
            ///Mapkit Challenge
            MapView(pictureLocation: user.location)
                .edgesIgnoringSafeArea(.top)
                .frame(height: 500)
            
            
            self.getImage(for: user)
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 200)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .offset(y: -100)
                .padding(.bottom, -130)
                .shadow(radius: 10)
            
            VStack(alignment: .leading) {
                Text(user.name)
                    .font(.title)
                    .padding(.bottom, 1)
                
                Text("Picture Location:")
                    .font(.subheadline)
                
                ///Mapkit Challenge
                if user.location?.latitude != 0.0 {
                    Text("Latitude: \(user.location?.latitude ?? 0) Longitude: \(user.location?.longitude ?? 0)")
                        .font(.caption)
                } else {
                    Text("Unknown")
                        .font(.caption)
                }
                
            }
            .padding(.top, 30)
            Spacer()
        }
    }
    
    private func getImage(for user: User) -> Image {
        guard let image = user.image else {
            return Image(systemName: "person.crop.square")
        }
        return Image(uiImage: image)
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailView(user: User())
    }
}
