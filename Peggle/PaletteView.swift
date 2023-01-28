//
//  PaletteView.swift
//  Peggle
//
//  Created by Lee Yong Ler on 24/1/23.
//

import SwiftUI

struct PaletteView: View {
//    @StateObject var board: Board = Board()
//    @ObservedObject var board: Board
    @Binding var board: Board
    @State private var name: String = "Level name"
    
    var body: some View {
        VStack() {
            GameView(board: board)
//            GameView(board: board)
            HStack {
                Button("LOAD") {
                    Task {
                        board = try await BoardStore.load(name: name)
                        print("LOAD")
                    }
                }
                Button("SAVE") {
                    Task {
                        do {
                            try await BoardStore.save(board: board, name: name)
                        } catch {

                        }
                    }
                    print("SAVE")
                }
                
                Button("RESET") {
                    board.clearBoard()
                }
                TextField("Level name", text: $name)
                    .border(.secondary)
                
                Button("START") {
                    print("START")
                }
            }
        }
        .padding()
    }
}

struct PaletteView_Previews: PreviewProvider {
    static var previews: some View {
//        PaletteView()
//        PaletteView(board: Board.sampleBoard)
        PaletteView(board: .constant(Board.sampleBoard))
    }
}
