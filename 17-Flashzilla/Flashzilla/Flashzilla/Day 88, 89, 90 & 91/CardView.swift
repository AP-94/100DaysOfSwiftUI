//
//  CardView.swift
//  CardView
//
//  Created by Alessandro Pace on 3/8/21.
//

import SwiftUI

struct CardView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityEnabled) var accessibilityEnabled
    
    let card: Card
    let retryWrongCards: Bool
    var removal: ((_ isCorrect: Bool) -> Void)? = nil
    
    @State private var isShowingAnswer = false
    @State private var offset = CGSize.zero
    @State private var feedBack = UINotificationFeedbackGenerator()
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(
                    differentiateWithoutColor
                    ? Color.white
                    : Color.white
                        .opacity(1 - Double(abs(offset.width / 50)))
                    
                )
                .background(
                    differentiateWithoutColor
                    ? nil
                    : RoundedRectangle(cornerRadius: 25, style: .continuous)
                        //Challenge 3
                        .fill(getBackgroundColor(for: offset))
                )
                .shadow(radius: 10)
            
            VStack {
                if accessibilityEnabled {
                    Text(isShowingAnswer ? card.answer : card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                } else {
                    Text(card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                    
                    if isShowingAnswer {
                        Text(card.answer)
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(Double(offset.width / 5)))
        .offset(x: offset.width * 5, y: 0)
        .opacity(2 - Double(abs(offset.width / 50)))
        .accessibility(addTraits: .isButton)
        .gesture(
            DragGesture()
                .onChanged({ gesture in
                    offset = gesture.translation
                    feedBack.prepare()
                })
                .onEnded({ _ in
                    if abs(offset.width) > 100 {
                        if offset.width > 0 {
                            feedBack.notificationOccurred(.success)
                        } else {
                            feedBack.notificationOccurred(.error)
                        }
                        
                        //Challenge 2
                        removal?(self.offset.width > 0)
                        
                        if retryWrongCards && offset.width < 0 {
                            offset = .zero
                        }
                        
                    } else {
                        offset = .zero
                    }
                })
        )
        .onTapGesture {
            isShowingAnswer.toggle()
        }
        .animation(.spring())
    }
    
    //Challenge 3
    private func getBackgroundColor(for offSet: CGSize) -> Color {
        var color: Color = .white
        
        if offSet.width > 0 {
            color = .green
        } else if offSet.width < 0 {
            color = .red
        }
        
        return color
    }
    
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.example, retryWrongCards: false)
    }
}
