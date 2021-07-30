//
//  UserCell.swift
//  iForgetNames
//
//  Created by Alessandro Pace on 28/7/21.
//

import SwiftUI

struct UserView: View {
    
    let user: User
    
    @State private var image: Image?
    
    var body: some View {
        HStack {
            self.getImage(for: user)
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.gray, lineWidth: 1))
            Text(user.name)
                .font(.title3)
        }
    }
    
    private func getImage(for user: User) -> Image {
        guard let image = user.image else {
            return Image(systemName: "person.crop.square")
        }
        return Image(uiImage: image)
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(user: User(userName: "Nombre de Prueba", inputImage: UIImage(named: "halo")!))
    }
}
