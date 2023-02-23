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
    
    var body: some Scene {
        WindowGroup {
//            GameView(peggleGame: peggleGame)
            PaletteView(paletteViewModel: paletteViewModel)
        }
    }
}
