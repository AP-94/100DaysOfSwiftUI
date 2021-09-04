//
//  FilterSheet.swift
//  FilterSheet
//
//  Created by Alessandro Pace on 4/9/21.
//

import SwiftUI

struct FilterSheet: View {
    
    @Environment(\.presentationMode) var presentationMode
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    @Binding var filterCountryName: String
    @Binding var filterSize: Int
    @Binding var filterPrice: Int
    
    var countries: [String] {
        var uniqueCountries: [String] = ["All"]
        resorts.forEach { resort in
            if !uniqueCountries.contains(resort.country) {
                uniqueCountries.append(resort.country)
            }
        }
        return uniqueCountries
    }
    
    var body: some View {
        Form {
            Section(header: Text("Filter Options")) {
                HStack {
                    Text("Country")
                    Spacer()
                    Picker("Country", selection: $filterCountryName) {
                        ForEach(countries, id: \.self) {
                            Text("\($0)").tag("\($0)")
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    
                }
                
                HStack {
                    Text("Size")
                    Spacer()
                    Picker("Size", selection: $filterSize) {
                        Text("Small").tag(1)
                        Text("Average").tag(2)
                        Text("Large").tag(3)
                        Text("none").tag(0)
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                
                HStack {
                    Text("Price")
                    Spacer()
                    Picker("Price", selection: $filterPrice) {
                        Text("$").tag(1)
                        Text("$$").tag(2)
                        Text("$$$").tag(3)
                        Text("none").tag(0)
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                
            }
            
            Button("Filter Resorts!") {
                presentationMode.wrappedValue.dismiss()
            }
            .font(.title2)
            .foregroundColor(Color.blue)
            
            Button("Reset Filters") {
                removeFilters()
            }
            .font(.callout)
            .foregroundColor(Color.gray)
        }
    }
    
    private func removeFilters() {
        filterPrice = 0
        filterSize = 0
        filterCountryName = "All"
        presentationMode.wrappedValue.dismiss()
    }
    
}

//struct FilterSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        FilterSheet(filterCountryName: "", filterSize: 0, filterPrice: 0)
//    }
//}
