//
//  CoreImageView.swift
//  Instafilter
//
//  Created by Alessandro Pace on 20/7/21.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct CoreImageView: View {
    @State private var image: Image?
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
        }
        .onAppear(perform: loadImage)
    }
    
    func loadImage() {
        guard let inputImage = UIImage(named: "haloInfinite") else {
            return
        }
        
        let beginImage = CIImage(image: inputImage)
        
        let context = CIContext()
        
//        let currentFilter = CIFilter.crystallize()
//
//        currentFilter.inputImage = beginImage
//        currentFilter.radius = 50
        
        guard let currentFilter = CIFilter(name: "CITwirlDistortion") else {
            return
        }
        
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        //currentFilter.setValue(2000, forKey: kCIInputRadiusKey)
        currentFilter.setValue(CIVector(x: inputImage.size.width / 2, y: inputImage.size.height / 2), forKey: kCIInputCenterKey)
        
        guard let outputImage = currentFilter.outputImage else {
            return
        }
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
        }
    }
}

struct CoreImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoreImageView()
    }
}
