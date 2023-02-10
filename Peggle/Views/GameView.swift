//
//  GameView.swift
//  Peggle
//
//  Created by Lee Yong Ler on 9/2/23.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var peggleGame: PeggleGameEngine
//    @ObservedObject var board: Board
    @State private var dragOffset = CGSize.zero
    
    var body: some View {
        ZStack {
//            BoardView(peggleGame: peggleGame, selectedButton: .constant(""), isDesigning: .constant(false))
            BoardView(peggleGame: peggleGame, board: peggleGame.board, selectedButton: .constant(""), isDesigning: .constant(false))
//                .onTapGesture {
//                    peggleGame.addPeg(color: "peg-blue", centre: CGPoint(x: 100, y: 100))
//                }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(peggleGame: (PeggleGameEngine()))
//        GameView(peggleGame: .constant(PeggleGameEngine()), board: .constant(Board.sampleBoard))
    }
}
