//
//  ResortView.swift
//  ResortView
//
//  Created by Alessandro Pace on 4/9/21.
//

import SwiftUI

struct ResortView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    @EnvironmentObject var favorites: Favorites
    @State private var selectedFacility: Facility?
    let resort: Resort
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                
                Image(decorative: resort.id)
                    .resizable()
                    .scaledToFit()
                    //CHALLENGE 1 IMAGE OVERLAY
                    .overlay(CreditOverlay(creditText: resort.imageCredit), alignment: .bottomTrailing)
                
                Group {
                    
                    HStack {
                        if sizeClass == .compact {
                            Spacer()
                            VStack {
                                ResortDetailsView(resort: resort)
                            }
                            VStack {
                                SkiDetailsView(resort: resort)
                            }
                            Spacer()
                        } else {
                            ResortDetailsView(resort: resort)
                            Spacer().frame(height: 0)
                            SkiDetailsView(resort: resort)
                        }
                    }
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .padding(.top)
                    
                    Text(resort.description)
                        .padding(.vertical)
                    Text("Facilities")
                        .font(.headline)
                    
                    //                    Ok code
                    //                    Text(resort.facilities.joined(separator: ", "))
                    //                        .padding(.vertical)
                    
                    //                    Great code
                    //                    Text(ListFormatter.localizedString(byJoining: resort.facilities))
                    //                        .padding(.vertical)
                    
                    //Representing facilities as an image
                    HStack {
                        ForEach(resort.facilityTypes) { facility in
                            facility.icon
                                .font(.title)
                                .onTapGesture {
                                    selectedFacility = facility
                                }
                        }
                    }
                    .padding(.vertical)
                    
                }
                
                .padding(.horizontal)
                
                Button(favorites.contains(resort) ? "Remove from Favorites" : "Add to Favorites") {
                    if favorites.contains(resort) {
                        favorites.remove(resort)
                    } else {
                        favorites.add(resort)
                    }
                }
                .padding()
            }
        }
        
        .navigationBarTitle("\(resort.name), \(resort.country)")
        .alert(item: $selectedFacility) { facility in
            facility.alert
        }
    }
}

/// Make String identifiable
//extension String: Identifiable {
//    public var id: String { self }
//}

struct ResortView_Previews: PreviewProvider {
    static var previews: some View {
        ResortView(resort: Resort.example)
    }
}
