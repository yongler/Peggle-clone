//
//  GameHeaderView.swift
//  Peggle
//
//  Created by Lee Yong Ler on 26/2/23.
//

import SwiftUI

struct GameHeaderView: View {
    @ObservedObject var gameViewModel: GameViewModel

    var body: some View {
        HStack {
            Spacer()
            Text("Score: \(gameViewModel.score)")
            Spacer()
            Text("Ball left: \(gameViewModel.ballsLeftCount)")
            Spacer()
            Text("Orange Peg left: \(gameViewModel.orangePegsLeftCount)")
            Spacer()
            Text("\(gameViewModel.timer)")
            Spacer()
        }
    }
}

struct GameHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        GameHeaderView(gameViewModel: GameViewModel())
    }
}
