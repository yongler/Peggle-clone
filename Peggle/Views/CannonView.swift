//
//  CannonView.swift
//  Peggle
//
//  Created by Lee Yong Ler on 24/2/23.
//

import SwiftUI

struct CannonView: View {
    @ObservedObject var gameViewModel: GameViewModel

    var body: some View {
        ZStack {

        Image(gameViewModel.cannonImage)
            .resizable()
            .frame(width: gameViewModel.cannonWidth, height: gameViewModel.cannonHeight)
            .rotationEffect(gameViewModel.angle, anchor: .center)
            .position(gameViewModel.cannonPosition)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { gesture in
                        gameViewModel.onDragCannon(to: gesture.location)
                    }
                    .onEnded { _ in
                        gameViewModel.onStopDragCannon()
                    }
            )

//            .onTapGesture {
//                gameViewModel.onTapCannon()
//            }
//                    .onEnded { _ in
//                    }
//            )

        }
    }
}

struct CannonView_Previews: PreviewProvider {
    static var previews: some View {
        CannonView(gameViewModel: GameViewModel())
    }
}
