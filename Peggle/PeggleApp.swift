//
//  PeggleApp.swift
//  Peggle
//
//  Created by Lee Yong Ler on 24/1/23.
//

import SwiftUI

@main
struct PeggleApp: App {
    @State var board = Board()

    var body: some Scene {
        WindowGroup {
            PaletteView(board: $board)
            // Automaticaly loads default saved level
            .task {
                   do {
                       board = try BoardStore.load(name: "peggle")
                   } catch {
                       fatalError("Error loading board.")
                   }
            }
        }
    }
}
