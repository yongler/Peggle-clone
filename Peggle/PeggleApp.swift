//
//  PeggleApp.swift
//  Peggle
//
//  Created by Lee Yong Ler on 24/1/23.
//

import SwiftUI

@main
struct PeggleApp: App {
    @State var peggleGame = PeggleGameEngine()
//    @ObservedObject var board = peggleGame.
    
//    init() {
//        peggleGame.createDisplayLink()
//        peggleGame.addBoardToGameEngine()
//        board = peggleGame.board
//    }
    
    var body: some Scene {
        WindowGroup {
                
            // Automaticaly loads default saved level
//                PaletteView(peggleGame: $peggleGame, board: $board)
                GameView(peggleGame: peggleGame)
//                GameView(peggleGame: $peggleGame, board: board)
                .task {
//                    board = Board.sampleBoard
                    peggleGame.addBoardToGameEngine()
                    peggleGame.createDisplayLink()
//                    do {
//                        board = try peggleGame.load(name: "peggle")
//                    } catch {
//                        fatalError("Error loading board.")
//                    }
                }
        }
    }
}
