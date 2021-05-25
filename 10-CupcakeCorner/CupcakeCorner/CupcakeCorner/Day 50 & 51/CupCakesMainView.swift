//
//  CupCakesMainView.swift
//  CupcakeCorner
//
//  Created by Alessandro Pace on 24/5/21.
//

import SwiftUI

struct CupCakesMainView: View {
    
    @ObservedObject var observedOrder = ObservedOrder(order: Order())
    
    var body: some View {
        
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $observedOrder.order.type) {
                        ForEach(Type.allCases, id: \.self) { type in
                            Text(type.rawValue)
                        }
                    }
                    
                    Stepper(value: $observedOrder.order.quantity, in: 3...20) {
                        Text("Number of cakes: \(observedOrder.order.quantity)")
                    }
                }
                
                Section {
                    Toggle(isOn: $observedOrder.order.specialRequestEnabled.animation()) {
                        Text("Any special requests?")
                    }
                    
                    if observedOrder.order.specialRequestEnabled {
                        Toggle(isOn: $observedOrder.order.extraFrosting) {
                            Text("Add extra frosting")
                        }
                        
                        Toggle(isOn: $observedOrder.order.addSprinkles) {
                            Text("Add extra sprinkles")
                        }
                    }
                }
                
                Section {
                    NavigationLink(
                        destination: AddressView(observedOrder: observedOrder)) {
                        Text("Delivery Details")
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
        
    }
}

struct CupCakesMainView_Previews: PreviewProvider {
    static var previews: some View {
        CupCakesMainView()
    }
}
