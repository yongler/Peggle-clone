//
//  PeggleApp.swift
//  Peggle
//
//  Created by Lee Yong Ler on 24/1/23.
//

import SwiftUI

@main
struct PeggleApp: App {
    @StateObject var paletteViewModel = PaletteViewModel()
    @StateObject var gameViewModel = GameViewModel()

    var body: some Scene {
        WindowGroup {
                PeggleView(paletteViewModel: paletteViewModel, gameViewModel: gameViewModel)
        }
    }
}
