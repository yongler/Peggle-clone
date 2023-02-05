//
//  PaletteActionButtonsView.swift
//  Peggle
//
//  Created by Lee Yong Ler on 29/1/23.
//

import SwiftUI

struct PaletteActionButtonsView: View {
    @Binding var board: Board
    @State private var name: String = ""
    @State private var alertMessage: String = ""
    @State private var hasAlert = false

    var body: some View {
        HStack {
            Button("LOAD") {
                do {
                    board = try BoardStore.load(name: name)
                } catch {
                    alertMessage = "Failed to load board"
                    hasAlert = true
                }
            }
            Button("SAVE") {
                guard !name.isEmpty else {
                    alertMessage = "Please specify a name to save"
                    hasAlert = true
                    return
                }
                do {
                    try BoardStore.save(board: board, name: name)
                } catch {
                    alertMessage = "Failed to save"
                    hasAlert = true
                }
            }
            .alert(alertMessage, isPresented: $hasAlert) {
                Button("OK", role: .cancel) {
                    hasAlert = false
                }
            }

            Button("RESET") { board.clearBoard() }

            TextField("Level name", text: $name).border(.secondary)

            Button("START") {}
        }
    }
}

struct PaletteActionButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        PaletteActionButtonsView(board: .constant(Board.sampleBoard))
    }
}
