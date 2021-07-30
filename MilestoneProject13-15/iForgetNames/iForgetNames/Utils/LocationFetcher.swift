//
//  LocationFetcher.swift
//  iForgetNames
//
//  Created by Alessandro Pace on 29/7/21.
//
// Copyrights to Paul Hudson - www.hackingwithswift.com

import CoreLocation

///Mapkit challenge: Location fetcher for when the users takes the photo
class LocationFetcher: NSObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    var lastKnownLocation: CLLocationCoordinate2D?

    override init() {
        super.init()
        manager.delegate = self
    }

    func start() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.first?.coordinate
    }
}
