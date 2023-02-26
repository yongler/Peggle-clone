//
//  GameMenuView.swift
//  Peggle
//
//  Created by Lee Yong Ler on 24/2/23.
//

import SwiftUI

struct GameMenuView: View {
    @ObservedObject var gameViewModel: GameViewModel

    var body: some View {
        ZStack {
            GeometryReader { geometry in
                BackgroundView()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .scaledToFill()

                Spacer()

                VStack {
                    Text("Please select your game mode")
                    Button("Normal Game") { gameViewModel.selectGameMode(.normalGame, gameArea: geometry.size) }
                    Button("Beat The Score") { gameViewModel.selectGameMode(.beatTheScore, gameArea: geometry.size) }
                    Button("Siam Left Siam Right") {
                        gameViewModel.selectGameMode(.siamLeftSiamRight, gameArea: geometry.size)

                    }
                }
            }

        }
        .ignoresSafeArea(.all)
    }
}

struct GameMenuView_Previews: PreviewProvider {
    static var previews: some View {
        GameMenuView(gameViewModel: GameViewModel())
    }
}
