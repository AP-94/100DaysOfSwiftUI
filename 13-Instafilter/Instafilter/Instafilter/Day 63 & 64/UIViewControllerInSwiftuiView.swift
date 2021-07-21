//
//  UIViewControllerInSwiftuiView.swift
//  Instafilter
//
//  Created by Alessandro Pace on 20/7/21.
//

import SwiftUI

struct UIViewControllerInSwiftuiView: View {
    @State private var image: Image?
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
            
            Button("Select Image") {
                self.showingImagePicker = true
            }
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: $inputImage)
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
//        UIImageWriteToSavedPhotosAlbum(inputImage, nil, nil, nil)
        
        let imageSaver = ImageSaver()
        
        imageSaver.successHandler = {
            print("Success!!")
        }
        
        imageSaver.errorHandler = {
            print("Oops!: \($0.localizedDescription)")
        }
        
        imageSaver.writeToPhotoAlbum(image: inputImage)
    }
}

struct UIViewControllerInSwiftuiView_Previews: PreviewProvider {
    static var previews: some View {
        UIViewControllerInSwiftuiView()
    }
}
