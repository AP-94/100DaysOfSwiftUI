//
//  AstronautView.swift
//  MoonShot
//
//  Created by Alessandro Pace on 5/5/21.
//

import SwiftUI

struct AstronautView: View {
    
    let astronaut: Astronaut
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let missionsIn: [Mission]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    ///PROJECT 15 - CHALLENGE 3
                    Image(decorative: self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                    
                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)
                    
                    //CHALLENGE 2
                    Text("Missions in:")
                        .font(.headline)
                        .padding()
                        ///PROJECT 15 - CHALLENGE 3
                        .accessibilityValue(Text("Missions of astronaut"))
                    
                    ForEach(self.missionsIn, id: \.id) { mission in
                        HStack {
                            ///PROJECT 15 - CHALLENGE 3
                            Image(decorative: mission.image)
                                .resizable()
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.primary, lineWidth: 2))
                                .padding(EdgeInsets(top: -10, leading: 40, bottom: 10, trailing: 10))
                            
                            
                            VStack(alignment: .leading) {
                                Text(mission.displayName)
                                    .font(.headline)
                                    .padding(EdgeInsets(top: -10, leading: 0, bottom: 10, trailing: 10))
                            }
                            
                            Spacer()
                        }
                    }
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
    
    //CHALLENGE 2 INIT VALUE FOR GETTING THE MISSIONSIN OF THE ASTRONAUT
    init(astronaut: Astronaut) {
        self.astronaut = astronaut
        
        var astronautMissions = [Mission]()
        
        for mission in missions {
            if mission.crew.contains(where: { (crew) -> Bool in
                astronaut.name.range(of: crew.name, options: .caseInsensitive) != nil
            }) {
                astronautMissions.append(mission)
            }
        }
        
        self.missionsIn = astronautMissions
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts[0])
    }
}
