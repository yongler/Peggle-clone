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
            Image(ImageViewModel.ballImage)
                .resizable()
                .frame(width: ball.radius * 2, height: ball.radius * 2)
                .position(ball.centre)
        }
    }
}

struct GameBallView_Previews: PreviewProvider {
    static var previews: some View {
        GameBallView(gameViewModel: GameViewModel())
    }
}
