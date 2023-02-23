//
//  BoardView.swift represents Game board with pegs
//  Peggle
//
//  Created by Lee Yong Ler on 24/1/23.
//

import SwiftUI

struct PaletteBoardView: View {
    @ObservedObject var paletteViewModel: PaletteViewModel
//    @State private var dragOffset = CGSize.zero

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
                                    paletteViewModel.addPeg(location: value.location)
                                }
                        )
                    
                    Text("\(paletteViewModel.board.pegs.count)")
                    
                    Spacer()

//                    BallView(peggleGame: peggleGame, ball: $board.ball)

                    ForEach(paletteViewModel.boardPegs, id: \.id) { peg in
                        Image(peg.color.rawValue)
                            .resizable()
                            .frame(width: peg.radius * 2, height: peg.radius * 2)
                            .position(peg.centre)
//                            .offset(dragOffset)
                            .onLongPressGesture(perform: {
                                paletteViewModel.pegOnLongPress(peg)
                            })
                            .gesture(
                                DragGesture(minimumDistance: 0)
                                    .onChanged { gesture in
    //                                                dragOffset = gesture.translation
    //                                            }
    //                                            .onEnded { gesture in
    //                                                dragOffset = .zero
                                        paletteViewModel.pegOnDrag(peg, by: gesture.translation)
                                    }
                            )
                            .onTapGesture { location in
                                print("tapping")
                                paletteViewModel.pegOnTap(at: location)
                            }
//                        PalettePegView(paletteViewModel: paletteViewModel, peg: peg)
                    }
                }

            }
//            .task {
//                peggleGame.setup(geometry.size)
//            }
        }
    }
}

struct PaletteBoardView_Previews: PreviewProvider {
    static var previews: some View {
        PaletteBoardView(paletteViewModel: PaletteViewModel())
    }
}
