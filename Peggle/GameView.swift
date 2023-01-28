//
//  GameView.swift
//  Peggle
//
//  Created by Lee Yong Ler on 24/1/23.
//

import SwiftUI

struct GameView: View {
//    @Binding var board: Board
    @ObservedObject var board: Board
    @State private var dragOffset = CGSize.zero
    @State private var selectedButton = ""
    
    var buttonSize: CGFloat = 80
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
                                guard selectedButton != "delete" else {
                                    return
                                }
                                board.addPeg(color: selectedButton, x: Float(value.location.x), y: Float(value.location.y), size: pegSize)
                            }
                     )
                
                Text(selectedButton)
                Spacer()
                
                ForEach($board.pegs, id: \.self) { $peg in
                    Image(peg.color)
                        .resizable()
                        .frame(width: CGFloat(pegSize), height: CGFloat(pegSize))
                        .position(x: CGFloat(peg.x), y: CGFloat(peg.y))
                        .gesture(
                            LongPressGesture(minimumDuration: 0.5)
                                .onEnded { _ in
                                    board.removePeg(peg)
                                }
                        )
                        .gesture(
                            DragGesture(minimumDistance: 50)
                                .onChanged { gesture in
                                    dragOffset = gesture.translation
                                }
                                .onEnded { gesture in
                                    peg.x += Float(gesture.translation.width)
                                    peg.y += Float(gesture.translation.height)
                                    dragOffset = .zero
                                }
                        )
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onEnded { gesture in
                                    guard selectedButton == "delete" else {
                                        return
                                    }
                                    
                                    board.removePeg(x: Float(gesture.location.x), y: Float(gesture.location.y))
                                }
                         )
                }
            }
            
            Spacer()
            
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
                    print("hiiii")
                }) {
                    Image("delete")
                      .resizable()
                      .frame(width: buttonSize, height: buttonSize, alignment: .bottomLeading)
                }
                
            }

        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(board: Board.sampleBoard)
//        GameView(board: .constant(Board.sampleBoard))
    }
}
