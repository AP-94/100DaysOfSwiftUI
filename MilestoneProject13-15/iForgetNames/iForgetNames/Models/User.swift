//
//  User.swift
//  iForgetNames
//
//  Created by Alessandro Pace on 28/7/21.
//

import Foundation
import SwiftUI
import CoreLocation

class ObservedUser: ObservableObject {
    @Published var user: User
    
    init(user: User) {
        self.user = user
    }
    
    func restoreUser() {
        user.name = ""
        user.image = nil
    }
}

struct User: Codable, Comparable, Hashable {
    
    static func < (lhs: User, rhs: User) -> Bool {
        lhs.name < rhs.name
    }
    
    var id = UUID()
    var name: String
    
    ///Mapkit challenge: added vars to store picture location
    private var locationLatitude: Double?
    private var locationLongitude: Double?
    private var imageData: Data?
    
    var image: UIImage? {
        get { UIImage(data: imageData ?? Data()) }
        set { imageData = newValue?.jpegData(compressionQuality: 0.8) }
    }
    
    ///Mapkit challenge: added computed property to store picture location
    var location: CLLocationCoordinate2D? {
        get {
            CLLocationCoordinate2D(latitude: locationLatitude ?? 0 , longitude: locationLongitude ?? 0)
        }
        set {
            locationLatitude = newValue?.latitude
            locationLongitude = newValue?.longitude
        }
    }
    
    init() {
        self.name = ""
    }
    
    init(userName: String, inputImage: UIImage) {
        self.name = userName
        self.image = inputImage
    }
    
}
