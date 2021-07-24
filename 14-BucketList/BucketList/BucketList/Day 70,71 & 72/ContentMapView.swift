//
//  ContentMapView.swift
//  BucketList
//
//  Created by Alessandro Pace on 24/7/21.
//

import SwiftUI
import LocalAuthentication

struct ContentMapView: View {
    
    @State private var isUnlocked = false
    
    ///CHALLENGE 3
    @State private var showingBiometricError = false
    @State private var authenticationErrorString = ""
    
    var body: some View {
        ZStack {
            if isUnlocked {
                MapCircleView()
            } else {
                Button("Unlock places!") {
                    authenticate()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
            }
        }
        ///CHALLENGE 3
        .alert(isPresented: $showingBiometricError) {
            Alert(title: Text("Error"), message: Text(authenticationErrorString), dismissButton: .default(Text("Ok")))
        }
        
    }
    
    private func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authenticate yourself to unlock your places."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                
                DispatchQueue.main.async {
                    if success {
                        isUnlocked = true
                    } else {
                        ///CHALLENGE 3
                        authenticationErrorString = error?.localizedDescription ?? "An error ocurred, try again later."
                        showingBiometricError = true
                    }
                }
            }
        } else {
            ///CHALLENGE 3
            authenticationErrorString = "Biometric auth not available"
            showingBiometricError = true
        }
    }
    
}

struct ContentMapView_Previews: PreviewProvider {
    static var previews: some View {
        ContentMapView()
    }
}
