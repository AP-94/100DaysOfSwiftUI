//
//  AddActivityView.swift
//  HabitsApp
//
//  Created by Alessandro Pace on 19/5/21.
//

import SwiftUI

struct AddActivityView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var activities: Activities
    @State private var title = ""
    @State private var description = ""
    @State private var emptyFields = false
    
    var body: some View {
        
        NavigationView {
            Form {
                TextField("Title", text: $title)
                TextField("Description", text: $description)
            }
            .navigationBarTitle("Add new activity")
            .navigationBarItems(trailing: Button("Save") {
                validateFieldsAndSaveActivity()
            })
            .alert(isPresented: $emptyFields) {
                Alert(title: Text("Fields Error"), message: Text("All fields must containt at least 1 character"), dismissButton: .default(Text("Ok"), action: {
                    emptyFields = false
                }))
            }
        }
        
    }
    
    func validateFieldsAndSaveActivity() {
        
        if title.isEmpty || description.isEmpty {
            emptyFields = true
        } else {
            let newActivity = Activity(title: self.title, description: self.description, completitionCount: 0)
            self.activities.items.append(newActivity)
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct AddActivityView_Previews: PreviewProvider {
    static var previews: some View {
        AddActivityView(activities: Activities())
    }
}
