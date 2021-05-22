//
//  Habits.swift
//  HabitsApp
//
//  Created by Alessandro Pace on 18/5/21.
//

import Foundation

class Activities: ObservableObject {
    
    @Published var items: [Activity] = [] {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "activities")
            }
        }
    }
    
    init() {
        if let items = UserDefaults.standard.data(forKey: "activities") {
            let decoder = JSONDecoder()
            if let decodedActivities = try? decoder.decode([Activity].self, from: items) {
                self.items = decodedActivities
                return
            }
        }
        
        self.items = []
    }
    
    func updateItems(activity: Activity) {
        let index = items.firstIndex(where: { $0.id == activity.id })
        
        if let i = index {
            items[i] = activity
        }
        
    }
    
    func getActivity(withUUID activityID: UUID) -> Activity? {
        return items.first { (activity) -> Bool in
            activity.id == activityID
        }
    }
}
