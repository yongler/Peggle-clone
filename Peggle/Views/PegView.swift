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
            .frame(width: peg.radius * 2, height: peg.radius * 2)
            .position(peg.centre)
            .offset(dragOffset)

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
                        
                        dragOffset = .zero
                        board.movePeg(peg, by: gesture.translation)
                    }
            )
            // Simulated Tap gesture
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onEnded { gesture in
                        guard selectedButton == "delete" && isDesigning else {
                            return
                        }

                        board.removePeg(at: gesture.location)
                    }
             )
    }
}