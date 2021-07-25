//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Alessandro Pace on 24/5/21.
//

import SwiftUI
import Network

struct CheckoutView: View {
    
    @ObservedObject var observedOrder: ObservedOrder
    @State private var alertMessage = ""
    @State private var titleMessage = ""
    @State private var showingConfirmation = false
    
    var body: some View {
        GeometryReader { geometryReader in
            ScrollView {
                VStack {
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometryReader.size.width)
                        .accessibility(hidden: true)  /// PROJECT 15 ACCESSIBILITY - CHALLENGE 1
                        
                    
                    Text("Your total is \(self.observedOrder.order.cost, specifier: "%.2f") $")
                        .font(.title)
                    
                    Button("Place order") {
                        self.placeOrder()
                    }
                    .padding()
                }
            }
        }
        .navigationBarTitle("Check out")
        .alert(isPresented: $showingConfirmation) {
            Alert(title: Text(titleMessage), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    private func placeOrder() {
        guard let encondedOrder = try? JSONEncoder().encode(observedOrder.order) else {
            print("FAIL TO ENCODE ORDER ---")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encondedOrder
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                //Challenge 2
                showError(message: "No data in response: \(error?.localizedDescription ?? "Unknown error").")
                return
            }
            
            if let decodedOrder = try? JSONDecoder().decode(Order.self, from: data) {
                DispatchQueue.main.async {
                    self.titleMessage = "Thank you!"
                    self.alertMessage = "Your order for \(decodedOrder.quantity)x \(decodedOrder.type.rawValue.lowercased()) cupcakes is on its way"
                    self.showingConfirmation = true
                }
                return
            } else {
                //Challenge 2
                showError(message: "Invalidad response from server")
            }
            
        }.resume()
        
    }
    
    //Challenge 2
    func showError(message: String) {
        self.titleMessage = "An error ocurred"
        self.alertMessage = message
        self.showingConfirmation = true
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(observedOrder: ObservedOrder(order: Order()))
    }
}
