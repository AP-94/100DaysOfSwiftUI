//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Alessandro Pace on 24/5/21.
//

import SwiftUI

struct AddressView: View {
    
    @ObservedObject var observedOrder: ObservedOrder
    
    var body: some View {
        
        Form {
            Section {
                TextField("Name", text: $observedOrder.order.name)
                TextField("Street Address", text: $observedOrder.order.streetAddress)
                TextField("City", text: $observedOrder.order.city)
                TextField("Zip Code", text: $observedOrder.order.zip)
            }
            
            Section {
                NavigationLink(destination: CheckoutView(observedOrder: observedOrder)) {
                    Text("Check out")
                }
            }
            .disabled(observedOrder.order.hasValidAddress == false)
        }
        .navigationBarTitle("Delivery Details", displayMode: .inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(observedOrder: ObservedOrder(order: Order()))
    }
}
