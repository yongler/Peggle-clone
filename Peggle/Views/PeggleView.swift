//
//  PeggleView.swift
//  Peggle
//
//  Created by Lee Yong Ler on 24/2/23.
//

import SwiftUI

struct PeggleView: View {
    @ObservedObject var paletteViewModel: PaletteViewModel
    @ObservedObject var gameViewModel: GameViewModel

    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                List {

                    NavigationLink("Play", destination: GameLevelsView(gameViewModel: gameViewModel))
                    NavigationLink("Design", destination: PaletteLevelsView(paletteViewModel: paletteViewModel))
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .task {
                paletteViewModel.updateGameArea(geometry.size)
                paletteViewModel.addSampleBoards(gameArea: geometry.size)
            }
        }
    }
}

struct PeggleView_Previews: PreviewProvider {
    static var previews: some View {
        PeggleView(paletteViewModel: PaletteViewModel(), gameViewModel: GameViewModel())
    }
}
