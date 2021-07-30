//
//  EditView.swift
//  iForgetNames
//
//  Created by Alessandro Pace on 28/7/21.
//

import SwiftUI

struct InputNameView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var observedUser: ObservedUser
    @State private var image: Image?
    
    var body: some View {
        NavigationView {
            VStack {
                image?
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                    .padding()
                
                TextField("Write name here", text: $observedUser.user.name)
                    .padding()
                
                Spacer()
            }
            
            .navigationBarTitle("Person name")
            .navigationBarItems(trailing: Button("Done") {
                presentationMode.wrappedValue.dismiss()
            })
        }
        .onAppear(perform: loadImage)
    }
    
    private func loadImage() {
        guard let inputImage = observedUser.user.image else { return }
        image = Image(uiImage: inputImage)
    }
}

struct InputNameView_Previews: PreviewProvider {
    static var previews: some View {
        InputNameView(observedUser: ObservedUser(user: User(userName: "Nombre de Prueba", inputImage: UIImage(named: "halo")!)))
    }
}
