//
//  ProjectView.swift
//  Instafilter
//
//  Created by Alessandro Pace on 21/7/21.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ProjectView: View {
    
    @State private var image: Image?
    @State private var filterIntensity = 0.5
    
    ///CHALLENGE 3: NEW FLOATS FOR SLIDERS
    @State private var filterRadius = 0.5
    @State private var filterScale = 0.5
    
    
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    @State var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    @State private var showingFiltersSheet = false
    
    @State private var processedImage: UIImage?
    
    @State private var showingImageSavedAlert = false
    @State private var imageSavedTitle = ""
    
    ///CHALLENGE 2: GET NAME OF FILTER
    @State private var currentFilterName = "Sepia Tone"
    
    var body: some View {
        let intensity = Binding<Double>(
            get: {
                filterIntensity
            },
            set: {
                filterIntensity = $0
                applyProcessing()
            }
        )
        
        ///CHALLENGE 3: SETTING BINDING
        let radius = Binding<Double>(
            get: {
                filterRadius
            },
            set: {
                filterRadius = $0
                applyProcessing()
            }
        )
        
        ///CHALLENGE 3: SETTING BINDING
        let scale = Binding<Double>(
            get: {
                filterScale
            },
            set: {
                filterScale = $0
                applyProcessing()
            }
        )
        
        return NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color.secondary)
                    
                    if image != nil {
                        image?
                            .resizable()
                            .scaledToFit()
                    } else {
                        Text("Tap to select a picture")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                }
                
                .onTapGesture {
                    showingImagePicker = true
                }
                
                ///CHALLENGE 3: IF FOR NEW SLIDERS
                VStack {
                    if currentFilter.inputKeys.contains(kCIInputIntensityKey) {
                        HStack {
                            Text("Intensity")
                            Spacer()
                            Slider(value: intensity)
                                .frame(width: 300)
                        }
                    }
                    
                    if currentFilter.inputKeys.contains(kCIInputRadiusKey) {
                        HStack {
                            Text("Radius")
                            Spacer()
                            Slider(value: radius)
                                .frame(width: 300)
                        }
                    }
                    
                    if currentFilter.inputKeys.contains(kCIInputScaleKey) {
                        HStack {
                            Text("Scale")
                            Spacer()
                            Slider(value: scale)
                                .frame(width: 300)
                        }
                    }
                }
                .padding(.vertical)
                
                HStack {
                    ///CHALLENGE 2: BUTTON CHANGES TITLE WITH FILTER TITLE
                    Button("Filter: \(currentFilterName)"){
                        showingFiltersSheet = true
                    }
                    
                    Spacer()
                    
                    Button("Save") {
                        saveEditedImage()
                    }
                }
            }
            
            .padding([.horizontal, .bottom])
            .navigationBarTitle("Instafilter")
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: $inputImage)
            }
            .actionSheet(isPresented: $showingFiltersSheet) {
                ActionSheet(title: Text("Select a filter"), buttons: [
                    .default(Text("Crystallize")) {
                        setFilter(CIFilter.crystallize(), withName: "Crystallize")
                    },
                    .default(Text("Edges")) {
                        setFilter(CIFilter.edges(), withName: "Edges")
                    },
                    .default(Text("Gaussian Blur")) {
                        setFilter(CIFilter.gaussianBlur(), withName: "Gaussian Blur")
                    },
                    .default(Text("Pixellate")) {
                        setFilter(CIFilter.pixellate(), withName: "Pixellate")
                    },
                    .default(Text("Sepia Tone")) {
                        setFilter(CIFilter.sepiaTone(), withName: "Sepia Tone")
                    },
                    .default(Text("Unsharp Mask")) {
                        setFilter(CIFilter.unsharpMask(), withName:  "Unsharp Mask")
                    },
                    .default(Text("Vignette")) {
                        setFilter(CIFilter.vignette(), withName: "Vignette")
                    },
                    .cancel()
                ])
            }
            .alert(isPresented: $showingImageSavedAlert, content: {
                Alert(title: Text(imageSavedTitle))
            })
        }
    }
    
    private func loadImage() {
        guard let inputImage = inputImage else { return }
        
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    private func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }
        
        if inputKeys.contains(kCIInputRadiusKey) {
            ///CHALLENGE 3: USED FILTER RADIUS INSTEAD
            currentFilter.setValue(filterRadius * 200, forKey: kCIInputRadiusKey)
        }
        
        if inputKeys.contains(kCIInputScaleKey) {
            ///CHALLENGE 3: USED FILTER SCALE INSTEAD
            currentFilter.setValue(filterScale * 10, forKey: kCIInputScaleKey)
        }
        
        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }
    
    private func setFilter(_ filter: CIFilter, withName filterName: String) {
        ///CHALLENGE 2: CHANGING FILTER NAME WITH CURRENT FILTER
        currentFilterName = filterName
        currentFilter = filter
        loadImage()
    }
    
    private func saveEditedImage() {
        if let imageToSave = processedImage {
            
            let imageSaver = ImageSaver()
            
            imageSaver.successHandler = {
                imageSavedTitle = "Image saved succesfully!"
                showingImageSavedAlert = true
            }
            
            imageSaver.errorHandler = {
                imageSavedTitle = "Oops an error ocurred: \($0.localizedDescription)"
                showingImageSavedAlert = true
            }
            
            imageSaver.writeToPhotoAlbum(image: imageToSave)
            
        } else {
            ///CHALLENGE 1: PROMPT ERROR IF NO IMAGE SELECTED
            imageSavedTitle = "You need to select an image first."
            showingImageSavedAlert = true
        }
        
    }
    
}

struct ProjectView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectView()
    }
}
