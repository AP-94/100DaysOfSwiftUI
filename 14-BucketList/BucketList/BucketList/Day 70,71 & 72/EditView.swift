//
//  EditView.swift
//  BucketList
//
//  Created by Alessandro Pace on 24/7/21.
//

import MapKit
import SwiftUI

struct EditView: View {
    
    private enum LoadingState{
        case loading, loaded, failed
    }
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var placemark: MKPointAnnotation
    @State private var loadingState = LoadingState.loading
    @State private var pages: [Page] = []
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Place name", text: $placemark.wrappedTitle)
                    TextField("Description", text: $placemark.wrappedSubtitle)
                }
                
                Section(header: Text("Nearby...")) {
                    switch loadingState {
                    case .loading:
                        Text("Loading...")
                    case .loaded:
                        List(pages, id: \.pageid) { page in
                            Text(page.title)
                                            .font(.headline)
                                        + Text(": ") +
                                Text(page.description)
                                            .italic()
                        }
                    default:
                        Text("Please try again later...")
                    }
                }
            }
            .navigationBarTitle("Edit place")
            .navigationBarItems(trailing: Button("Done") {
                presentationMode.wrappedValue.dismiss()
            })
            .onAppear(perform: fetchNearbyPlaces)
        }
    }
    
    private func fetchNearbyPlaces() {
        let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(placemark.coordinate.latitude)%7C\(placemark.coordinate.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
        
        guard let url = URL(string: urlString) else {
            print("Base URL error")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                
                if let items = try? decoder.decode(Result.self, from: data) {
                    self.pages = Array(items.query.pages.values).sorted()
                    self.loadingState = .loaded
                    return
                }
            }
            
            self.loadingState = .failed
        }.resume()

    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(placemark: MKPointAnnotation.example)
    }
}
