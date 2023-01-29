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
                                    let tappedLocationX = Float(value.location.x)
                                    let tappedLocationY = Float(value.location.y)
                                    let radius = Constants.Peg.pegRadius

                                    guard Utils.checkInArea(gameArea: geometry.size, pegX: tappedLocationX,
                                                            pegY: tappedLocationY, pegRadius: radius) else {
                                        return
                                    }

                                    let peg = Peg(color: selectedButton, x: tappedLocationX,
                                                  y: tappedLocationY, radius: radius)
                                    board.addPeg(peg)
                                }
                        )

                    Spacer()

                    ForEach($board.pegs, id: \.self) { peg in
                        PegView(board: board, peg: peg, selectedButton: $selectedButton,
                                isDesigning: $isDesigning, gameArea: .constant(geometry.size))
                    }
                }

            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(board: Board.sampleBoard, selectedButton: .constant(""), isDesigning: .constant(true))
    }
}
