//
//  MissionView.swift
//  MoonShot
//
//  Created by Alessandro Pace on 5/5/21.
//

import SwiftUI

struct MissionView: View {
    
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    let astronauts: [CrewMember]
    
    var body: some View {
        
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    
                    ///PROJECT 15 - CHALLENGE 3
                    ///PROJECT 18 - CHALLENGE 1 (RESIZE IMAGE WHEN SCROLL)
                    GeometryReader { geo in
                        Image(decorative: self.mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: geo.size.width, height: geo.size.height)
                            .padding(.top)
                            .scaleEffect(1 - calculateScaleFor(headGeo: geometry, imageGeo: geo))
                            .offset(x: 0, y: calculateScaleFor(headGeo: geometry, imageGeo: geo) * geo.size.height / 2)
                    }
                    .frame(height: geometry.size.width * 0.7)
                    
                    //CHALLENGE 1
                    Text("Launch Date: \(self.mission.formattedLaunchDate)")
                        .padding()
                        .font(.headline)
                        ///PROJECT 15 - CHALLENGE 3
                        .accessibility(value: Text("Launch date of mission: \(self.mission.formattedLaunchDate)"))
                    
                    Text(self.mission.description)
                        .padding()
                        .layoutPriority(1)
                    
                    Spacer(minLength: 25)
                    
                    ForEach(self.astronauts, id: \.role) { crewMember in
                        NavigationLink(
                            destination: AstronautView(astronaut: crewMember.astronaut)) {
                            HStack {
                                Image(crewMember.astronaut.id)
                                    .resizable()
                                    .frame(width: 83, height: 60)
                                    .clipShape(Capsule())
                                    .overlay(Capsule().stroke(Color.primary, lineWidth: 1.5))
                                    ///PROJECT 15 - CHALLENGE 3
                                    .accessibility(value: Text("Picture of crew member: \(crewMember.astronaut.name)"))
                                
                                VStack(alignment: .leading) {
                                    Text(crewMember.astronaut.name)
                                        .font(.headline)
                                    Text(crewMember.role)
                                        .foregroundColor(crewMember.role == "Commander" ? .orange : .secondary)
                                }
                                ///PROJECT 15 - CHALLENGE 3
                                .accessibilityElement(children: .ignore)
                                .accessibility(label: Text("Astronaut \(crewMember.astronaut.name) with Role \(crewMember.role)"))
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }
        .navigationBarTitle(Text(mission.displayName), displayMode: .inline)
    }
    
    init(mission: Mission, astronauts: [Astronaut]) {
        self.mission = mission
        
        var matches = [CrewMember]()
        
        for member in mission.crew {
            if let match = astronauts.first(where: { $0.id == member.name }) {
                matches.append(CrewMember(role: member.role, astronaut: match))
            } else {
                fatalError("Missing \(member)")
            }
        }
        
        self.astronauts = matches
    }
    
    /// PROJECT 18 - CHALLENGE 1
       private func calculateScaleFor(headGeo: GeometryProxy, imageGeo: GeometryProxy) -> CGFloat {
           let imagePosition = imageGeo.frame(in: .global).minY
           let safeAreaHeight = headGeo.safeAreaInsets.top

           return -min(0.5, (imagePosition - safeAreaHeight) / 500)
       }
    
}


struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
    }
}
