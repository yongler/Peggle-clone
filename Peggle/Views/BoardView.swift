//
//  BoardView.swift represents Game board with pegs
//  Peggle
//
//  Created by Lee Yong Ler on 24/1/23.
//

import SwiftUI

struct BoardView: View {
    @ObservedObject var peggleGame: PeggleGameEngine
    @Binding var board: Board
    @Binding var selectedButton: String
    @Binding var isDesigning: Bool

    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack {
                    Image("background")
                        .resizable()
                        .background()
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onEnded { value in
                                    guard selectedButton != "delete" && isDesigning else {
                                        return
                                    }

                                    peggleGame.addPeg(color: selectedButton, centre: value.location)
                                }
                        )

                    Spacer()

                    Text(String(board.gameArea.width / 2))
                        .position(x: board.gameArea.width / 2, y: 100)

                    Text("bro")
                        .position(x: geometry.size.width, y: geometry.size.height)
//                    Image("delete")
////                        .position(x)
//                        .resizable()
//                        .frame(width: board.gameArea.width/2,
//                               height: board.gameArea.height/2)

                    BallView(peggleGame: peggleGame, ball: $board.ball, isDesigning: $isDesigning)

                    ForEach($board.pegs) { peg in
                        PegView(peggleGame: peggleGame, board: board, peg: peg, selectedButton: $selectedButton,
                                isDesigning: $isDesigning)
                    }
                }

            }
            .task {
                peggleGame.updateGameArea(geometry.size)
            }
        }
    }
}

struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        BoardView(peggleGame: (PeggleGameEngine()), board: .constant(Board.sampleBoard),
                  selectedButton: .constant(""), isDesigning: .constant(true))

//        BoardView(peggleGame: .constant(PeggleGameEngine()), board:
//            .constant(Board.sampleBoard), selectedButton: .constant(""), isDesigning: .constant(true))
    }
}
