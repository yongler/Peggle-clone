////
////  GameView.swift
////  Peggle
////
////  Created by Lee Yong Ler on 9/2/23.
////
//
//import SwiftUI
//
//struct GameView: View {
//    @ObservedObject var peggleGame: PeggleGameEngine
//    @State private var dragOffset = CGSize.zero
//
//    var body: some View {
//        ZStack {
//            BoardView(peggleGame: peggleGame, board: $peggleGame.board,
//                      selectedButton: .constant(""), isDesigning: .constant(false))
//        }
//    }
//}
//
//struct GameView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameView(peggleGame: (PeggleGameEngine()))
//    }
//}
//
////
//////
//////  BoardView.swift represents Game board with pegs
//////  Peggle
//////
//////  Created by Lee Yong Ler on 24/1/23.
//////
////
////import SwiftUI
////
////struct BoardView: View {
////    @ObservedObject var peggleGame: PeggleGameEngine
////    @Binding var board: Board
////    @Binding var selectedButton: String
////    @Binding var isDesigning: Bool
////
////    var body: some View {
////        GeometryReader { geometry in
////            VStack {
////                ZStack {
////                    Image("background")
////                        .resizable()
////                        .background()
////                        .gesture(
////                            DragGesture(minimumDistance: 0)
////                                .onEnded { value in
////                                    guard selectedButton != "delete" && isDesigning else {
////                                        return
////                                    }
////
////                                    peggleGame.addPeg(color: selectedButton, centre: value.location)
////                                }
////                        )
////
////                    Spacer()
////
////                    BallView(peggleGame: peggleGame, ball: $board.ball, isDesigning: $isDesigning)
////
////                    ForEach($board.pegs) { peg in
////                        PegView(peggleGame: peggleGame, board: board, peg: peg, selectedButton: $selectedButton,
////                                isDesigning: $isDesigning)
////                    }
////                }
////
////            }
////            .task {
////                peggleGame.setup(geometry.size)
////            }
////        }
////    }
////}
////
////struct BoardView_Previews: PreviewProvider {
////    static var previews: some View {
////        BoardView(peggleGame: (PeggleGameEngine()), board: .constant(Board.sampleBoard),
////                  selectedButton: .constant(""), isDesigning: .constant(true))
////    }
////}
