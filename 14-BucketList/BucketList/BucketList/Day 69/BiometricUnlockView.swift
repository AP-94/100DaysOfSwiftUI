//
//  BiometricUnlockView.swift
//  BucketList
//
//  Created by Alessandro Pace on 23/7/21.
//

import LocalAuthentication
import SwiftUI

struct BiometricUnlockView: View {
    
    @State private var isUnlocked = false
    
    var body: some View {
        VStack {
            if isUnlocked {
                Text("- - Unlocked - -")
            } else {
                Text("* * LOCKED * *")
            }
        }
        .onAppear(perform: aunthenticate)
    }
    
    private func aunthenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to unlock your data"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                
                DispatchQueue.main.async {
                    if success {
                        isUnlocked = true
                    } else {
                        isUnlocked = false
                    }
                }
            }
        } else {
            
        }
    }
}

struct BiometricUnlockView_Previews: PreviewProvider {
    static var previews: some View {
        BiometricUnlockView()
    }
}
