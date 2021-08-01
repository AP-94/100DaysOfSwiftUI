//
//  ContentView.swift
//  iForgetNames
//
//  Created by Alessandro Pace on 28/7/21.
//

import SwiftUI

private enum ActiveSheet {
    case imagePicker, addUserName
}

struct ContentView: View {
    let locationFetcher = LocationFetcher()
    @ObservedObject var observedUsers = ObservedUsers()
    @ObservedObject var observedUser = ObservedUser(user: User())
    @State private var activeSheet: ActiveSheet = .imagePicker
    @State private var showSheet = false
    @State private var selectedImage: UIImage?
    @State private var selectedName: String?
    
    var body: some View {
        NavigationView {
            ZStack {
                List(observedUsers.users, id: \.self) { user in
                    NavigationLink(
                        destination: UserDetailView(user: user)) {
                        UserView(user: user)
                    }
                }
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            showSheet = true
                            activeSheet = .imagePicker
                        }) {
                            Image(systemName: "plus")
                                .padding()
                                .background(Color.black.opacity(0.75))
                                .foregroundColor(.white)
                                .font(.title)
                                .clipShape(Circle())
                                .padding([.bottom,.trailing])
                        }
                    }
                }
                
            }
            .navigationBarTitle("iForgetNames")
            .sheet(isPresented: $showSheet, onDismiss: sheetDismissed) {
                if activeSheet == .imagePicker {
                    ImagePicker(image: $selectedImage)
                } else {
                    InputNameView(observedUser: observedUser)
                }
            }
            .onAppear(perform: locationFetcher.start)
            
        }
    }
    
    private func sheetDismissed() {
        if activeSheet == .imagePicker {
            verifyImageAndPromptNameInput()
        } else {
            saveNewUser()
        }
    }
    
    private func verifyImageAndPromptNameInput() {
        guard let selectedImage = selectedImage else { return }
        ///Mapkit Challenge: Get user location
        observedUser.user.location = locationFetcher.lastKnownLocation
        observedUser.user.image = selectedImage
        showSheet = true
        activeSheet = .addUserName
    }
    
    private func saveNewUser() {
        observedUsers.users.append(observedUser.user)
        observedUsers.saveUsersToDocumentsDirectory()
        observedUser.restoreUser()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
