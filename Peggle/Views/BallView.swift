//
//  BallView.swift
//  Peggle
//
//  Created by Lee Yong Ler on 10/2/23.
//

import SwiftUI

struct BallView: View {
    @ObservedObject var peggleGame: PeggleGameEngine
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
                            dragOffset = gesture.translation
                        }
                        .onEnded { gesture in
                            dragOffset = .zero
                            peggleGame.moveBall(by: gesture.translation)
                        }
                )
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onEnded { gesture in
                            peggleGame.launchBall()
                        }
                 )
        }
            
    }
}

struct BallView_Previews: PreviewProvider {
    static var previews: some View {
        BallView(peggleGame: (PeggleGameEngine()), ball: .constant(Ball.sampleBall), isDesigning: .constant(false))
    }
}
