//
//  ActivityView.swift
//  HabitsApp
//
//  Created by Alessandro Pace on 19/5/21.
//

import SwiftUI

struct ActivityView: View {
    var title: String
    var description: String
    var completedTimes: Int
    
    var body: some View {
        
        HStack (spacing: 10) {
            VStack (alignment: .leading) {
                Text(title)
                    .font(.title)
                    .padding(EdgeInsets(top: 5, leading: 10, bottom: 0, trailing: 0))
                Text(description)
                    .foregroundColor(.gray)
                    .font(.subheadline)
                    .bold()
                    .padding(EdgeInsets(top: 5, leading: 10, bottom: 0, trailing: 0))
            }
            
            Spacer()
            
            VStack (){
                Text("\(completedTimes)")
                    .font(.largeTitle)
                    .foregroundColor(completedTimes == 0 ? .red : .blue)
                    .bold()
                Text(completedTimes == 1 ? "Completition" : "Completitions")
                    .foregroundColor(.gray)
                    .font(.footnote)
            }
            
        }
        .frame(
            minWidth: 0,
            maxWidth: .infinity
          )
        .padding(10)
        .background(Color.white)
        .clipped()
        .cornerRadius(10)
        .shadow(color: .gray, radius: 2)
        
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView(title: "Activity Title", description: "Example of an activty description", completedTimes: 2)
    }
}
