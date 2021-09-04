//
//  MainView.swift
//  MainView
//
//  Created by Alessandro Pace on 4/9/21.
//

import SwiftUI

//CHALLENGE 3
enum SortType {
    case name, country, none
}

struct MainView: View {
    @ObservedObject var favorites = Favorites()
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    //CHALLENGE 3 SORT VARS
    @State private var isShowingSortSheet = false
    
    ////CHALLENGE 3 FILTER VARS
    @State private var isShowingFilterSheet = false
    @State private var filterCountryNameSelection = "All"
    @State private var filterSizeSelection = 0
    @State private var filterPriceSelection = 0
    @State private var sortSelection: SortType = .none
    
    var sortedResorts: [Resort] {
        switch sortSelection {
        case .none:
            return resorts
        case .name:
            return resorts.sorted { $0.name < $1.name }
        case .country:
            return resorts.sorted { $0.country < $1.country }
        }
    }
    
    var filteredResorts: [Resort] {
        return getFilteredResortsList()
    }
    
    
    var body: some View {
        NavigationView {
            List(filteredResorts) { resort in
                NavigationLink {
                    ResortView(resort: resort)
                } label: {
                    
                    Image(resort.country)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 45, height: 25)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 5)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(.black, lineWidth: 1)
                        )
                    
                    VStack(alignment: .leading) {
                        Text(resort.name)
                            .font(.headline)
                        Text("\(resort.runs) runs")
                            .foregroundColor(.secondary)
                    }.layoutPriority(1)
                    
                    if favorites.contains(resort) {
                        Spacer()
                        Image(systemName: "heart.fill")
                            .accessibility(label: Text("This is a favorite resort"))
                            .foregroundColor(.red)
                    }
                    
                }
                
            }
            .navigationBarTitle("Resorts")
            //CHALLENGE 3 SORT AND FILTER BUTTONS
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button("Sort") {
                        isShowingSortSheet = true
                    }
                    
                    Button("Filter") {
                        isShowingFilterSheet = true
                    }
                }
            }
            
            //CHALLENGE 3
            .sheet(isPresented: $isShowingFilterSheet) {
                FilterSheet(filterCountryName: $filterCountryNameSelection, filterSize: $filterSizeSelection, filterPrice: $filterPriceSelection)
            }
            
            //CHALLENGE 3
            .actionSheet(isPresented: $isShowingSortSheet) {
                ActionSheet(title: Text("Sort Resorts"), buttons: [
                    .default(Text("By name")) {
                        sortSelection = .name
                    },
                    .default(Text("By country")) {
                        sortSelection = .country
                    },
                    .default(Text("default")) {
                        sortSelection = .none
                    }
                ])
            }
            
            WelcomeView()
        }
        //.phoneOnlyStackNavigationView()
        .environmentObject(favorites)
    }
    
    //CHALLENGE 3
    private func getFilteredResortsList() -> [Resort] {
        let countriesFiltered = filterCountryNameSelection == "All" ? sortedResorts : sortedResorts.filter { $0.country == filterCountryNameSelection }
        let sizesFiltered = filterSizeSelection == 0 ? countriesFiltered : countriesFiltered.filter { $0.size == filterSizeSelection }
        let pricesFiltered = filterPriceSelection == 0 ? sizesFiltered : sizesFiltered.filter { $0.price == filterPriceSelection }
        
        return pricesFiltered
    }
}

extension View {
    func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return AnyView(self.navigationViewStyle(StackNavigationViewStyle()))
        } else {
            return AnyView(self)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
