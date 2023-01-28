//
//  PeggleApp.swift
//  Peggle
//
//  Created by Lee Yong Ler on 24/1/23.
//

import SwiftUI

@main
struct PeggleApp: App {
//    @StateObject private var boardStore = BoardStore()
    @State var board = Board()

    var body: some Scene {
        WindowGroup {
//                PaletteView(board: .constant(Board.sampleBoard))
            PaletteView(board: $board)
            .task {
                   do {
                       board = try await BoardStore.load(name: "peggle.data")
                   } catch {
                       fatalError("Error loading scrums.")
                   }
               }
        }
    }
}
