//
//  DeleteList.swift
//  iExpense
//
//  Created by Alessandro Pace on 30/4/21.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Int
}

class Expenses: ObservableObject {
    @Published var items: [ExpenseItem] = [] {
        didSet {
                let encoder = JSONEncoder()
                if let encoded = try? encoder.encode(items) {
                    UserDefaults.standard.set(encoded, forKey: "Items")
                }
            }
    }
    
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([ExpenseItem].self, from: items) {
                self.items = decoded
                return
            }
        }

        self.items = []
    }
}

struct DeleteListView: View {
    
    @ObservedObject var expenses = Expenses()
    @State private var addViewExpenseShown = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }

                            Spacer()
                            Text("$\(item.amount)")
                                .foregroundColor(getStyledColor(for: item.amount))
                        }
                }
                .onDelete(perform: { indexSet in
                    removeItems(at: indexSet)
                })
            }
            .navigationBarTitle("iExpense")
            //CHALLENGE 1:: ADD EDIT BUTTON
            .navigationBarItems(leading: EditButton(),trailing:
                                    Button(action: {
                                        addViewExpenseShown = true
                                    }) {
                                        Image(systemName: "plus")
                                    }
            )
            .sheet(isPresented: $addViewExpenseShown) {
                AddView(expenses: self.expenses)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
    
    //CHALLENGE 2:: STYLE TO AMOUNTS
    func getStyledColor(for amount: Int) -> Color {
        switch amount {
        case 0...10:
            return .green
        case 10...100:
            return .orange
        default:
            return .red
        }
    }
}

struct DeleteListView_Previews: PreviewProvider {
    static var previews: some View {
        DeleteListView()
    }
}
