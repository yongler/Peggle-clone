//
//  GameBoardView.swift
//
//  Created by Lee Yong Ler on 24/1/23.
//

import SwiftUI

struct GameBoardView: View {
    @ObservedObject var gameViewModel: GameViewModel
    @State var boardName: String

    var body: some View {

        GeometryReader { geometry in
            VStack {
                GameHeaderView(gameViewModel: gameViewModel)

                ZStack {
                    BackgroundView()

                    CannonView(gameViewModel: gameViewModel)
                    GameBallView(gameViewModel: gameViewModel)
                    BucketView(gameViewModel: gameViewModel)

                    ForEach($gameViewModel.boardPegs) { peg in GamePegView(gameViewModel: gameViewModel, peg: peg) }
                    ForEach($gameViewModel.boardBlocks) { block in BlockView(block: block) }
                    
                    if gameViewModel.hasNotSelectedGameMode {
                        GameMenuView(gameViewModel: gameViewModel)
                    }
                }
                .alert(gameViewModel.gameEndMessage, isPresented: $gameViewModel.hasGameEndMessage) {
                    Button("OK", role: .cancel) {
                    }
                }
                .alert(gameViewModel.alertMessage, isPresented: $gameViewModel.hasAlert) {
                    Button("OK", role: .cancel) {
                        gameViewModel.closeAlert()
                    }
                }
//                    .alert(gameViewModel.isLuckyMessage, isPresented: $gameViewModel.isLucky) {
//                        Button("YAYY", role: .cancel) {
//                            gameViewModel.closePopup()
//                        }
//                    }
//                    .task {
//                        gameViewModel.setupGame(gameArea: geometry.size)
//                    }
            }
            .task {
                gameViewModel.loadLevel(name: boardName)
                gameViewModel.setupGame(gameArea: geometry.size)
                print("loading from board \(gameViewModel.boardBlocks) ")
            }
        }
    }
}

struct GameBoardView_Previews: PreviewProvider {
    static var previews: some View {
        GameBoardView(gameViewModel: GameViewModel(), boardName: "hello")
    }
}
