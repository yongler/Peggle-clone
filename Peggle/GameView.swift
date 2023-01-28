//
//  GameView.swift
//  Peggle
//
//  Created by Lee Yong Ler on 24/1/23.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var board: Board
    @Binding var selectedButton: String
    @Binding var isDesigning: Bool
    
    var pegSize: Float = 50

    var body: some View {
        VStack {
            ZStack {
                Image("background")
                    .resizable()
//                    .clipped()
//                    .scaledToFit()
//                    .aspectRatio(contentMode: .fill)
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onEnded { value in
                                guard selectedButton != "delete" && isDesigning else {
                                    return
                                }
                                board.addPeg(color: selectedButton, x: Float(value.location.x), y: Float(value.location.y), size: pegSize)
                            }
                     )
                
                Spacer()
                
                ForEach($board.pegs, id: \.self) { peg in
                    PegView(board: board, peg: peg, selectedButton: $selectedButton, isDesigning: $isDesigning)
                }
            }
            
            Spacer()
            

        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(board: Board.sampleBoard, selectedButton: .constant(""), isDesigning: .constant(true))
//        GameView(board: .constant(Board.sampleBoard))
    }
}
