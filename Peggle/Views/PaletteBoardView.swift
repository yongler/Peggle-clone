//
//  BoardView.swift represents Game board with pegs
//  Peggle
//
//  Created by Lee Yong Ler on 24/1/23.
//

import SwiftUI

struct PaletteBoardView: View {
    @ObservedObject var paletteViewModel: PaletteViewModel
    
    @ObservedObject var peggleGame: PeggleGameEngine
    @Binding var board: Board
    @Binding var selectedButton: String

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
                                    paletteViewModel.addPeg(location: value.location)
                                }
                        )

                    Spacer()

                    BallView(peggleGame: peggleGame, ball: $board.ball)

                    ForEach($board.pegs) { peg in
                        PalettePegView(peggleGame: peggleGame, board: board, peg: peg, selectedButton: $selectedButton)
                    }
                }

            }
            .task {
                peggleGame.setup(geometry.size)
            }
        }
    }
}

struct PaletteBoardView_Previews: PreviewProvider {
    static var previews: some View {
        PaletteBoardView(paletteViewModel: PaletteViewModel())
    }
}
