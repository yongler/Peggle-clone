//
//  PaletteView.swift
//  Peggle
//
//  Created by Lee Yong Ler on 24/1/23.
//

import SwiftUI

struct PaletteView: View {
    @ObservedObject var peggleGame: PeggleGameEngine
    @Binding var board: Board
    @State private var selectedButton = ""

    var body: some View {
        VStack {
            BoardView(peggleGame: peggleGame, board: board, selectedButton: $selectedButton, isDesigning: .constant(true))
            PaletteDesignButtonsView(peggleGame: $peggleGame, selectedButton: $selectedButton)
            PaletteActionButtonsView(peggleGame: $peggleGame, board: $board)

        }
        .padding()
    }
}

struct PaletteView_Previews: PreviewProvider {
    static var previews: some View {
        PaletteView(peggleGame: (PeggleGameEngine()), board: .constant(Board.sampleBoard))
    }
}
