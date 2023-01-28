//
//  PegView.swift
//  Peggle
//
//  Created by Lee Yong Ler on 28/1/23.
//

import SwiftUI

struct PegView: View {
    @ObservedObject var board: Board
    @Binding var peg: Peg
    @Binding var selectedButton: String
    @Binding var isDesigning: Bool
    @Binding var gameArea: CGSize
    @State private var dragOffset = CGSize.zero

    var body: some View {
        Image(peg.color)
            .resizable()
            .frame(width: CGFloat(peg.radius * 2), height: CGFloat(peg.radius * 2))
            .position(x: CGFloat(peg.x), y: CGFloat(peg.y))

            .gesture(
                LongPressGesture(minimumDuration: 0.5)
                    .onEnded { _ in
                        guard isDesigning else {
                            return
                        }
                        board.removePeg(peg)
                    }
            )
            .gesture(
                DragGesture(minimumDistance: 50)
                    .onChanged { gesture in
                        guard isDesigning else {
                            return
                        }

                        dragOffset = gesture.translation
                    }
                    .onEnded { gesture in
                        guard isDesigning else {
                            return
                        }

                        peg.x += Float(gesture.translation.width)
                        peg.y += Float(gesture.translation.height)
                        dragOffset = .zero

                        guard board.checkValidPosition(peg: peg) else {
                            board.removePeg(peg)
                            return
                        }

                        guard Utils.checkInArea(gameArea: gameArea, pegX: peg.x,
                                                pegY: peg.y, pegRadius: peg.radius) else {
                            board.removePeg(peg)
                            return
                        }
                    }
            )
            // Simulated Tap gesture
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onEnded { gesture in
                        guard selectedButton == "delete" && isDesigning else {
                            return
                        }

                        board.removePeg(x: Float(gesture.location.x), y: Float(gesture.location.y))
                    }
             )
    }
}
