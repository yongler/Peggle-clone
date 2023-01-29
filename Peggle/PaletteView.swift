//
//  PaletteView.swift
//  Peggle
//
//  Created by Lee Yong Ler on 24/1/23.
//

import SwiftUI

struct PaletteView: View {
    @Binding var board: Board
    @State private var selectedButton = ""

    var body: some View {
        VStack {
            GameView(board: board, selectedButton: $selectedButton, isDesigning: .constant(true))
            PaletteDesignButtonsView(selectedButton: $selectedButton)
            PaletteActionButtonsView(board: $board)

        }
        .padding()
    }
}

struct PaletteView_Previews: PreviewProvider {
    static var previews: some View {
        PaletteView(board: .constant(Board.sampleBoard))
    }
}
