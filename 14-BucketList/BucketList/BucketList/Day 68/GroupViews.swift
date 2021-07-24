//
//  GroupViews.swift
//  BucketList
//
//  Created by Alessandro Pace on 22/7/21.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        Text("Loading...")
    }
}

struct SuccessView: View {
    var body: some View {
        Text("Success!")
    }
}

struct FailedView: View {
    var body: some View {
        Text("Failed.")
    }
}

struct GroupViews: View {
    
    private enum LoadingState {
        case loading, success, failed
    }
    
    private var loadingState = LoadingState.failed

    
    var body: some View {
        Group {
            switch loadingState {
            case .loading:
                LoadingView()
            case .success:
                SuccessView()
            default:
                FailedView()
            }
        }
    }
}

struct GroupViews_Previews: PreviewProvider {
    static var previews: some View {
        GroupViews()
    }
}
