//
//  GameBallView.swift
//  Peggle
//
//  Created by Lee Yong Ler on 10/2/23.
//

import SwiftUI

struct GameBallView: View {
    @ObservedObject var gameViewModel: GameViewModel
    
    var body: some View {
        if let ball = gameViewModel.board.ball {
            Image(Ball.image)
                .resizable()
                .frame(width: ball.radius * 2, height: ball.radius * 2)
                .position(ball.centre)
                .gesture(
                    DragGesture(minimumDistance: 50)
                        .onChanged { gesture in
                            gameViewModel.onDragBall(by: gesture.translation)
                        }
                )
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onEnded { _ in
                            gameViewModel.onTapBall()
                        }
                 )
        }
    }
}

struct GameBallView_Previews: PreviewProvider {
    static var previews: some View {
        GameBallView(gameViewModel: GameViewModel())
    }
}
