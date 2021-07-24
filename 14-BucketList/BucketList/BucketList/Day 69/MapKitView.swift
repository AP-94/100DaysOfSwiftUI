//
//  MapKitView.swift
//  BucketList
//
//  Created by Alessandro Pace on 23/7/21.
//

import MapKit
import SwiftUI

struct MapKitView: View {
    
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var locations: [MKPointAnnotation] = []
    @State private var selectedPlace: MKPointAnnotation?
    @State private var showingPlaceDetails = false
    
    var body: some View {
        MapView(centerCoordinate: $centerCoordinate, selectedPlace: $selectedPlace, showingPlaceDetails: $showingPlaceDetails, annotations: locations)
                    .edgesIgnoringSafeArea(.all)
    }
}

struct MapKitView_Previews: PreviewProvider {
    static var previews: some View {
        MapKitView()
    }
}
