//
//  ContentView.swift
//  HabitsApp
//
//  Created by Alessandro Pace on 18/5/21.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var activities = Activities()
    @State private var addNewActivityView = false
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(activities.items) { item in
                    NavigationLink(
                        destination: ActivityDetailView(activities: activities, activityUUID: item.id)) {
                        ActivityView(title: item.title, description: item.description, completedTimes: item.completitionCount)
                    }
                }
                .onDelete(perform: { indexSet in
                    removeItems(at: indexSet)
                })
            }
            .onAppear {
                // Set the default to clear
                UITableView.appearance().backgroundColor = .clear
                
            }
            .navigationBarTitle("MyHabits")
            .navigationBarItems(leading: EditButton(),trailing:
                                    Button(action: {
                                        addNewActivityView = true
                                    }) {
                                        Image(systemName: "plus")
                                    }
            )
            .sheet(isPresented: $addNewActivityView) {
                AddActivityView(activities: self.activities)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        activities.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
