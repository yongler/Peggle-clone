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
    
    var body: some View {
        VStack {
            GameView(board: $board)
            HStack {
                Button("LOAD") {
                    Task {
                        do {
                            board = try await BoardStore.load(name: "peggle.data")
                        } catch {
                            
                        }
                        print("LOAD")
                    }
                }
                Button("SAVE") {
                    Task {
                        do {
                            try await BoardStore.save(board: board, name: "peggle.data")
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
        PaletteView(board: .constant(Board.sampleBoard))
    }
}
