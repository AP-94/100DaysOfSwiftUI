//
//  MapCircleView.swift
//  BucketList
//
//  Created by Alessandro Pace on 24/7/21.
//

import SwiftUI
import MapKit

///CHALLENGE 2 MOVE MAP WITH LOGIC TO OTHER VIEW

struct MapCircleView: View {
    
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var locations: [CodableMKPointAnnotation] = []
    @State private var selectedPlace: MKPointAnnotation?
    @State private var showingPlaceDetails = false
    @State private var showingEditScreen = false
    
    var body: some View {
        ZStack {
            MapView(centerCoordinate: $centerCoordinate, selectedPlace: $selectedPlace, showingPlaceDetails: $showingPlaceDetails, annotations: locations)
                .edgesIgnoringSafeArea(.all)
            Circle()
                .fill(Color.blue)
                .opacity(0.3)
                .frame(width: 32, height: 32)
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        addNewLocation()
                    }) {
                        ///CHALLENGE  1: MOVE THE MODIFIERS TO THE IMAGE
                        Image(systemName: "plus")
                            .padding()
                            .background(Color.black.opacity(0.75))
                            .foregroundColor(.white)
                            .font(.title)
                            .clipShape(Circle())
                            .padding(.trailing)
                    }
                }
            }
        }
        
        .alert(isPresented: $showingPlaceDetails, content: {
            Alert(title: Text(selectedPlace?.title ?? "Unknown"), message: Text(selectedPlace?.subtitle ?? "Missing place information") , primaryButton: .default(Text("OK")), secondaryButton: .default(Text("Edit")) {
                showingEditScreen = true
            })
        })
        .sheet(isPresented: $showingEditScreen, onDismiss: saveData) {
            if let place = selectedPlace {
                EditView(placemark: place)
            }
        }
        .onAppear(perform: loadData)
    }
    
    private func addNewLocation() {
        let newLocation = CodableMKPointAnnotation()
        newLocation.coordinate = self.centerCoordinate
        newLocation.title = "Location"
        locations.append(newLocation)
        selectedPlace = newLocation
        showingEditScreen = true
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    private func loadData() {
        let fileName = getDocumentsDirectory().appendingPathComponent("SavedPlaces")
        do {
            let data = try Data(contentsOf: fileName)
            locations = try JSONDecoder().decode([CodableMKPointAnnotation].self, from: data)
        } catch {
            print("Unable to load saved data.")
        }
    }
    
    private func saveData() {
        
        do {
            let filename = getDocumentsDirectory().appendingPathComponent("SavedPlaces")
            let data = try JSONEncoder().encode(locations)
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
}
