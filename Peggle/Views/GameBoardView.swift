//
//  GameBoardView.swift
//
//  Created by Lee Yong Ler on 24/1/23.
//

import SwiftUI

struct GameBoardView: View {
    @ObservedObject var paletteViewModel: PaletteViewModel

    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack {
                    Image("background")
                        .resizable()
                        .background()
                    
                    Spacer()

//                    BallView(peggleGame: peggleGame, ball: $board.ball)

                    ForEach($paletteViewModel.boardPegs) { peg in
                        PalettePegView(paletteViewModel: paletteViewModel, peg: peg)
                    }
                }

            }
        }
    }
}

struct GameBoardView_Previews: PreviewProvider {
    static var previews: some View {
        GameBoardView(paletteViewModel: PaletteViewModel())
    }
}
