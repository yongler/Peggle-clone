//
//  GameBoardView.swift
//
//  Created by Lee Yong Ler on 24/1/23.
//

import SwiftUI

struct GameBoardView: View {
    @ObservedObject var gameViewModel: GameViewModel

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image("background")
                    .resizable()
                    .background()
                
                Spacer()
                Text("Balls left \(gameViewModel.ballsLeftCount)")
                CannonView(gameViewModel: gameViewModel)
                GameBallView(gameViewModel: gameViewModel)
                BucketView(gameViewModel: gameViewModel)
                
                ForEach($gameViewModel.boardPegs) { peg in
                    GamePegView(gameViewModel: gameViewModel, peg: peg)
                }
            }
            .alert(gameViewModel.gameEndMessage, isPresented: $gameViewModel.hasGameEndMessage) {
                Button("OK", role: .cancel) {
//                        gameViewModel.endGame()
                }
            }
            .task {
                gameViewModel.setupGame(gameArea: geometry.size)
            }
        }
    }
}

struct GameBoardView_Previews: PreviewProvider {
    static var previews: some View {
        GameBoardView(gameViewModel: GameViewModel())
    }
}
