//
//  PaletteView.swift
//  Peggle
//
//  Created by Lee Yong Ler on 24/1/23.
//

import SwiftUI

struct PaletteView: View {
    @Binding var board: Board
    @State private var name: String = "Level name"
    @State private var selectedButton = ""

    var body: some View {
        VStack() {
            // Game board with pegs
            GameView(board: board, selectedButton: $selectedButton, isDesigning: .constant(true))
            
            // 2 peg buttons and 1 delete button.
            HStack {
                Button(action: {
                    selectedButton = "peg-blue"
                }) {
                    Image("peg-blue")
                      .resizable()
                      .frame(width: K.Palette.buttonRadius, height: K.Palette.buttonRadius, alignment: .bottomLeading)
                }
                .opacity(selectedButton == "peg-blue" ? 1 : 0.5)
                
                Button(action: {
                    selectedButton = "peg-orange"
                }) {
                    Image("peg-orange")
                      .resizable()
                      .frame(width: K.Palette.buttonRadius, height: K.Palette.buttonRadius, alignment: .bottomLeading)
                }
                .opacity(selectedButton == "peg-orange" ? 1 : 0.5)
                
                Spacer()
                Button(action: {
                    selectedButton = "delete"
                }) {
                    Image("delete")
                      .resizable()
                      .frame(width: K.Palette.buttonRadius, height: K.Palette.buttonRadius, alignment: .bottomLeading)
                }
                .opacity(selectedButton == "delete" ? 1 : 0.5)
                
            }
            
            // Action buttons.
            HStack {
                Button("LOAD") {
                    Task {
                        board = try await BoardStore.load(name: name)
                    }
                }
                Button("SAVE") {
                    Task {
                        do {
                            try await BoardStore.save(board: board, name: name)
                        } catch {
                            print("Fail save")
                        }
                    }
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
        PaletteView(board: .constant(Board.sampleBoard))
    }
}
