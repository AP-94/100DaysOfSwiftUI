//
//  MainView.swift
//  MainView
//
//  Created by Alessandro Pace on 31/7/21.
//

import CodeScanner
import SwiftUI

enum ProspectsFilterType {
    case none, contacted, uncontacted
}

struct ProspectsView: View {
    
    @EnvironmentObject var prospects: Prospects
    @State private var isShowingSortSheet = false
    @State private var isShowingScanner = false
    let filter: ProspectsFilterType
    
    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted people"
        case .uncontacted:
            return "Uncontacted people"
        }
    }
    
    var filteredProspects: [Prospect] {
        switch filter {
        case .none:
            return prospects.people
        case .contacted:
            return prospects.people.filter { $0.isContacted }
        case .uncontacted:
            return prospects.people.filter { !$0.isContacted }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredProspects) { prospect in
                    ProspectView(prospect: prospect, filter: filter)
                        .environmentObject(prospects)
                }
            }
            .navigationTitle(title)
            //Challenge 3 Sort Button
            .navigationBarItems(leading: Button("Sort") {
                isShowingSortSheet = true
            }, trailing: Button(action: {
                isShowingScanner = true
            }) {
                Image(systemName: "qrcode.viewfinder")
                Text("Scan")
            }
            )
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "\(randomName())\nemail@mail.com", completion: handleScan)
                
            }
            //Challenge 3 Sort
            .actionSheet(isPresented: $isShowingSortSheet) {
                ActionSheet(title: Text("Filter people"), buttons: [
                    .default(Text("By name")) {
                        prospects.sortByNames()
                    },
                    .default(Text("By most recent")) {
                        prospects.sortByMostRecent()
                    }
                ])
            }
        }
    }
    
    private func handleScan(result: Result<String, CodeScannerView.ScanError>) {
        isShowingScanner = false
        
        switch result {
        case .success(let code):
            let details = code.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            
            let person = Prospect()
            person.name = details[0]
            person.emailAddress = details[1]
            prospects.add(person)
            
        case .failure:
            print("Scanning failed")
        }
    }
    
    private func randomName() -> String {
        let names = ["Carl", "Paul", "Jhon", "Ivanna", "Arantxa", "Francesco", "Savanah", "Eric", "Julia", "Martina"]
        return names.randomElement() ?? "Alessandro"
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none)
    }
}
