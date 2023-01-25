//
//  PeggleApp.swift
//  Peggle
//
//  Created by Lee Yong Ler on 24/1/23.
//

import SwiftUI

@main
struct PeggleApp: App {
    @StateObject private var boardStore = BoardStore()

    var body: some Scene {
        WindowGroup {
            NavigationView {
//                PaletteView(board: .constant(Board.sampleBoard))
            }
        }
    }
}
