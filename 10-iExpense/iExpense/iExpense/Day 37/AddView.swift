//
//  AddView.swift
//  iExpense
//
//  Created by Alessandro Pace on 30/4/21.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var expenses: Expenses
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    @State private var amountError = false
    
    static let types = ["Bussines","Personal"]
    
    var body: some View {
        
        NavigationView {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
            }
            .navigationBarTitle("Add new expense")
            .navigationBarItems(trailing: Button("Save") {
                getNumberFromAmountTextField(strAmount: self.amount)
            })
            //CHALLENGE 3 ALERT WHEN AMOUNT ITS NOT A NUMBER
            .alert(isPresented: $amountError) {
                Alert(title: Text("Amount Error"), message: Text("The amount field can only be numbers"), dismissButton: .default(Text("Ok"), action: {
                    amountError = false
                }))
            }
        }
    }
    
    func getNumberFromAmountTextField(strAmount: String) {
        
        guard let actualAmount = Int(strAmount) else {
            return amountError = true
        }
        let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
        self.expenses.items.append(item)
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
