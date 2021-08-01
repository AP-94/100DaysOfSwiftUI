//
//  TestingSamplePackageView.swift
//  TestingSamplePackageView
//
//  Created by Alessandro Pace on 31/7/21.
//

import SamplePackage
import SwiftUI

struct TestingSamplePackageView: View {
    
    let possibleNumbers = Array(1...60)
    
    var results: String {
        let selected = possibleNumbers.random(7).sorted()
        let strings = selected.map(String.init)
        return strings.joined(separator: ", ")
    }
    
    var body: some View {
        
        Text(results)
    }
    
    
}

struct TestingSamplePackageView_Previews: PreviewProvider {
    static var previews: some View {
        TestingSamplePackageView()
    }
}
