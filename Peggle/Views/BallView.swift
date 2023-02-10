//
//  BallView.swift
//  Peggle
//
//  Created by Lee Yong Ler on 10/2/23.
//

import SwiftUI

struct BallView: View {
    @Binding var ball: Ball?
    @Binding var isDesigning: Bool
    @State private var dragOffset = CGSize.zero
    
    var body: some View {
        if !isDesigning && ball != nil {
            Image(Ball.image)
                .resizable()
                .frame(width: ball!.radius * 2, height: ball!.radius * 2)
                .position(ball!.centre)
                .offset(dragOffset)
                .gesture(
                    DragGesture(minimumDistance: 50)
                        .onChanged { gesture in
                            guard isDesigning else {
                                return
                            }
                            
                            dragOffset = gesture.translation
                        }
                        .onEnded { gesture in
                            guard isDesigning else {
                                return
                            }
                            
                            dragOffset = .zero
                        }
                )
        }
            
    }
}

struct BallView_Previews: PreviewProvider {
    static var previews: some View {
        BallView(ball: .constant(Ball.sampleBall), isDesigning: .constant(false))
    }
}
