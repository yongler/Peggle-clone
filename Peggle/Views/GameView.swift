//
//  GameView.swift represents Game board with pegs
//  Peggle
//
//  Created by Lee Yong Ler on 24/1/23.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var board: Board
    @Binding var selectedButton: String
    @Binding var isDesigning: Bool
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack {
                    Image("background")
                        .resizable()
                        .background()
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onEnded { value in
                                    guard selectedButton != "delete" && isDesigning else {
                                        return
                                    }

                                    board.addPeg(color: selectedButton, centre: value.location)
                                }
                        )

                    Spacer()
                    
                    ForEach($board.pegs) { peg in
                        PegView(board: board, peg: peg, selectedButton: $selectedButton,
                                isDesigning: $isDesigning, gameArea: .constant(geometry.size))
                    }
                }

            }
            .task {
                board.updateGameArea(geometry.size)
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(board: Board.sampleBoard, selectedButton: .constant(""), isDesigning: .constant(true))
    }
}
