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
                Image("background")
                    .resizable()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .scaledToFill()
            }

            Spacer()

            VStack {
                Text("Please select your game mode")
                Button("Normal Game") { gameViewModel.selectGameMode(.normalGame) }
                Button("Beat The Score") { gameViewModel.selectGameMode(.beatTheScore) }
                Button("Siam Left Siam Right") { gameViewModel.selectGameMode(.siamLeftSiamRight) }
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
