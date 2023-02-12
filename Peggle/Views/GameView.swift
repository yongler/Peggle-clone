//
//  GameView.swift
//  Peggle
//
//  Created by Lee Yong Ler on 9/2/23.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var peggleGame: PeggleGameEngine
    @State private var dragOffset = CGSize.zero

    var body: some View {
        ZStack {
            BoardView(peggleGame: peggleGame, board: $peggleGame.board,
                      selectedButton: .constant(""), isDesigning: .constant(false))
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(peggleGame: (PeggleGameEngine()))
    }
}
