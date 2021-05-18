//
//  ArrowView.swift
//  Drawing
//
//  Created by Alessandro Pace on 18/5/21.
//

import SwiftUI

struct Arrow: InsettableShape {
    
    var rectangleWidth: CGFloat = 30
    var baseOfTriangle: CGFloat = 100
    var insetAmount: CGFloat = 0
    
    //Challenge 1
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX - rectangleWidth, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX + rectangleWidth, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX + rectangleWidth, y: rect.midY))
        
        path.addLine(to: CGPoint(x: rect.midX + baseOfTriangle, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX - baseOfTriangle, y: rect.midY))
        
        path.addLine(to: CGPoint(x: rect.midX - rectangleWidth, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX - rectangleWidth, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX + rectangleWidth, y: rect.maxY))
        
        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arrow = self
        arrow.insetAmount += amount
        return arrow
    }
}

struct ArrowView: View {
    
    @State private var lineWidth: CGFloat = 1
    
    var body: some View {
        
        Arrow()
            .strokeBorder(Color.blue, lineWidth: lineWidth)
            .frame(width: 150, height: 150)
            //Challenge 2
            .onTapGesture {
                withAnimation(.linear(duration: 2)) {
                    self.lineWidth = CGFloat.random(in: 1...15)
                }
            }
    }
}

struct ArrowView_Previews: PreviewProvider {
    static var previews: some View {
        ArrowView()
    }
}
