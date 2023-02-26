//
//  GameLevelsView.swift
//  Peggle
//
//  Created by Lee Yong Ler on 24/2/23.
//

import SwiftUI

struct GameLevelsView: View {
    @ObservedObject var gameViewModel: GameViewModel

    var body: some View {
        NavigationView {
            List {
                ForEach(0..<gameViewModel.boardNames.count, id: \.self) {
                    let boardName = gameViewModel.boardNames[$0]
                    NavigationLink(boardName,
                                   destination: GameBoardView(gameViewModel: gameViewModel, boardName: boardName))
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .task {
            gameViewModel.loadLevelsName()
        }
    }
}

struct GameLevelsView_Previews: PreviewProvider {
    static var previews: some View {
        GameLevelsView(gameViewModel: GameViewModel())
    }
}
