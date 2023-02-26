//
//  PeggleApp.swift
//  Peggle
//
//  Created by Lee Yong Ler on 24/1/23.
//

import SwiftUI

@main
struct PeggleApp: App {
//    @State var peggleGame = PeggleGameEngine()
    @StateObject var paletteViewModel = PaletteViewModel()
    @StateObject var gameViewModel = GameViewModel()

    var body: some Scene {
        WindowGroup {
//            GameBoardView(gameViewModel: gameViewModel)
            PeggleView(paletteViewModel: paletteViewModel, gameViewModel: gameViewModel)
//            LevelsView(paletteViewModel: paletteViewModel)
//            GameLevelsView(gameViewModel: gameViewModel)
//            PaletteView(paletteViewModel: paletteViewModel)

        }
    }
}
