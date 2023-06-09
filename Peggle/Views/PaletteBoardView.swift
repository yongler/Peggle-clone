//
//  BoardView.swift represents Game board with pegs
//  Peggle
//
//  Created by Lee Yong Ler on 24/1/23.
//

import SwiftUI

struct PaletteBoardView: View {
    @ObservedObject var paletteViewModel: PaletteViewModel

    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack {
                    BackgroundView()
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onEnded { value in
                                    paletteViewModel.onTapBackground(location: value.location)
                                }
                        )

                    Spacer()

                    ForEach($paletteViewModel.boardPegs) { peg in
                        PalettePegView(paletteViewModel: paletteViewModel, peg: peg)
                    }
                    ForEach($paletteViewModel.boardBlocks) { block in
                        BlockView(paletteViewModel: paletteViewModel, block: block)
                    }
                }

            }
            .task {
                paletteViewModel.updateGameArea(geometry.size)
            }
        }
    }
}

struct PaletteBoardView_Previews: PreviewProvider {
    static var previews: some View {
        PaletteBoardView(paletteViewModel: PaletteViewModel())
    }
}
