//
//  GameView.swift
//  Peggle
//
//  Created by Lee Yong Ler on 24/1/23.
//

import SwiftUI

struct GameView: View {
    @Binding var board: Board
    @State var selectedButton: String = "Level name"
    @State private var dragOffset = CGSize.zero
    var buttonSize: CGFloat = 80
    var pegSize: CGFloat = 50

    var body: some View {
        VStack {
            ZStack {
                    Image("background")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .gesture(
                             TapGesture()
                                 .onEnded { _ in
                                 }
                         )
                    
                    ForEach($board.pegs, id: \.self) { $peg in
                        Image(peg.color)
                            .resizable()
                            .frame(width: pegSize, height: pegSize)
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
        GameView()
    }
}
