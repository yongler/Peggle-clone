//
//  PegView.swift
//  Peggle
//
//  Created by Lee Yong Ler on 28/1/23.
//

import SwiftUI

struct PegView: View {
    @ObservedObject var peggleGame: PeggleGameEngine
    @ObservedObject var board: Board
    @Binding var peg: Peg
    @Binding var selectedButton: String
    @Binding var isDesigning: Bool
    @State private var dragOffset = CGSize.zero
    @State var isVisible = true

    var body: some View {
        ZStack {
            Button("hi") {
                isVisible.toggle()
//                withAnimation(.easeInOut(duration: 1.0)) {
//                    isVisible.toggle()
//                }
            }
            
            if isVisible {
                Image(peg.color)
                    .resizable()
                    .frame(width: peg.radius * 2, height: peg.radius * 2)
                    .position(peg.centre)
                    .offset(dragOffset)
                    .animation(.easeInOut(duration: 1), value: isVisible)
//                    .transition(AnyTransition.scale)
                
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
    }
}

struct PegView_Previews: PreviewProvider {
    static var previews: some View {
//        PegView(board: .constant(Board.sampleBoard), peg: .constant(Peg.sampleBluePeg1), selectedButton: .constant(""), isDesigning: .constant(true))
        PegView(peggleGame: (PeggleGameEngine()), board: (Board.sampleBoard), peg: .constant(Peg.sampleBluePeg1), selectedButton: .constant(""), isDesigning: .constant(true))
    }
}
