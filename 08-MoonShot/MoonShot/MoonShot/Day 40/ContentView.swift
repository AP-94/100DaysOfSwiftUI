//
//  ContentView.swift
//  MoonShot
//
//  Created by Alessandro Pace on 5/5/21.
//

import SwiftUI

struct ContentView: View {
    
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var barButtonName = "Show Crew Names"
    @State private var showMissionsDate = true
    
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(
                    destination: MissionView(mission: mission, astronauts: astronauts)) {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        ///PROJECT 15 - CHALLENGE 3
                        .accessibility(value: Text("\(mission.displayName) emblem."))
                        .frame(width: 44, height: 44)
                    
                    VStack(alignment: .leading)  {
                        Text(mission.displayName)
                            .font(.headline)
                            ///PROJECT 15 - CHALLENGE 3
                            .accessibility(value: Text("Mission name: \(mission.displayName)"))
                        //CHALLENGE 3
                        if showMissionsDate {
                            Text(mission.formattedLaunchDate)
                                ///PROJECT 15 - CHALLENGE 3
                                .accessibility(value: Text("Launch date: \(mission.formattedLaunchDate)"))
                        } else {
                            ForEach(mission.crew, id: \.name) { crewMember in
                                Text(getFullName(for: crewMember.name))
                                    ///PROJECT 15 - CHALLENGE 3
                                    .accessibility(value: Text("Crew member: \(getFullName(for: crewMember.name))"))
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("MoonShot")
            //CHALLENGE 3
            .navigationBarItems(trailing: Button("\(barButtonName)") {
                showMissionsDate.toggle()
                barButtonName = showMissionsDate ? "Show Crew Names" : "Show Launch Date"
            })
        }
    }
    
    //CHALLENGE 3
    func getFullName(for crewName: String) -> String {
        var fullName = ""
        
        fullName = astronauts.first { (astronaut) -> Bool in
            astronaut.name.range(of: crewName, options: .caseInsensitive) != nil
        }?.name ?? ""
        
        return fullName
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
