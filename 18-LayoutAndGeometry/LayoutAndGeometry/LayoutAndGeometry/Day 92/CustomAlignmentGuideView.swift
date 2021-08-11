//
//  CustomAlignmentGuideView.swift
//  CustomAlignmentGuideView
//
//  Created by Alessandro Pace on 10/8/21.
//

import SwiftUI

extension VerticalAlignment {
    enum MidAccountAndName: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[.top]
        }
    }
    
    static let midAccountAndName =  VerticalAlignment(MidAccountAndName.self)
}

struct CustomAlignmentGuideView: View {
    var body: some View {
        HStack(alignment: .midAccountAndName) {
            VStack {
                Text("@masterchief117")
                    .alignmentGuide(.midAccountAndName) { d in
                        d[VerticalAlignment.center]
                    }
                Image("masterChief")
                    .resizable()
                    .frame(width: 64, height: 64)
            }
            
            VStack {
                Text("Full name:")
                Text("John 117")
                    .alignmentGuide(.midAccountAndName) { d in
                        d[VerticalAlignment.center]
                    }
                    .font(.largeTitle)
            }
        }
    }
}

struct CustomAlignmentGuideView_Previews: PreviewProvider {
    static var previews: some View {
        CustomAlignmentGuideView()
    }
}
