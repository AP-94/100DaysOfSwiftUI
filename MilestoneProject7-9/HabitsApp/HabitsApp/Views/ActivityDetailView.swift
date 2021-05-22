//
//  ActivityDetailView.swift
//  HabitsApp
//
//  Created by Alessandro Pace on 19/5/21.
//

import SwiftUI

struct ActivityDetailView: View {
    
    @ObservedObject var activities: Activities
    var activityUUID: UUID
    
    var activity: Activity? {
        activities.getActivity(withUUID: activityUUID)
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("Description:")
                    .font(.headline)
                    .padding(EdgeInsets(top: 16, leading: 16, bottom: 1, trailing: 0))
                    .frame(minWidth: 100, maxWidth: .infinity, minHeight: 50, maxHeight: 50, alignment: .leading)
                
                Text(activity?.description ?? "This is a description")
                    .font(.body)
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0))
                    .frame(minWidth: 100, maxWidth: .infinity, minHeight: 50, maxHeight: 50, alignment: .leading)
                
                Text("Times Completed:")
                    .font(.headline)
                    .padding(EdgeInsets(top: 16, leading: 16, bottom: 1, trailing: 0))
                    .frame(minWidth: 100, maxWidth: .infinity, minHeight: 50, maxHeight: 50, alignment: .leading)
                
                Text("\(activity?.completitionCount ?? 0)")
                    .padding()
                    .foregroundColor(activity?.completitionCount == 0 ? .red : .blue)
                    .font(.largeTitle)
                    .frame(minWidth: 100, maxWidth: .infinity, minHeight: 50, maxHeight: 50, alignment: .leading)
                
                Button("Add 1 completion to habbit") {
                    addActivityCompletition()
                }
                .frame(width: 250, height: 50)
                .background(Color.blue)
                .animation(.default)
                .foregroundColor(.white)
                .font(.headline)
                .clipShape(Capsule())
                .animation(.default)
                
                Spacer()
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            
            .navigationBarTitle(activity?.title ?? "Title of Habit")
        }
    }
    
    func addActivityCompletition() {
        var newActivity = activity
        newActivity?.completitionCount += 1
        
        if let activityToUpdate = newActivity {
            activities.updateItems(activity: activityToUpdate)
        }
        
    }
    
}

struct ActivityDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityDetailView(activities: Activities(), activityUUID: UUID())
    }
}
