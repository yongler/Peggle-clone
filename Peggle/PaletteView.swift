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
    var buttonSize: CGFloat = 80

    var body: some View {
        VStack() {
            GameView(board: board, selectedButton: $selectedButton, isDesigning: .constant(true))
            
            HStack {
                Button(action: {
                    selectedButton = "peg-blue"
                }) {
                    Image("peg-blue")
                      .resizable()
                      .frame(width: buttonSize, height: buttonSize, alignment: .bottomLeading)
                }
                
                Button(action: {
                    selectedButton = "peg-orange"
                }) {
                    Image("peg-orange")
                      .resizable()
                      .frame(width: buttonSize, height: buttonSize, alignment: .bottomLeading)
                }
                Spacer()
                Button(action: {
                    selectedButton = "delete"
                }) {
                    Image("delete")
                      .resizable()
                      .frame(width: buttonSize, height: buttonSize, alignment: .bottomLeading)
                }
                
            }

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
        PaletteView(board: .constant(Board.sampleBoard))
    }
}
