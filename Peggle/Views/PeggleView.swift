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
    let welcomeMessage = "Welcome to Blue Lock Peggle!"

    var body: some View {
        GeometryReader { geometry in
                VStack {
                    Spacer()
                    Spacer()
                    NavigationView {
                        List {
                            Text(welcomeMessage).font(.largeTitle).padding(.all)
                            NavigationLink("Play", destination: GameLevelsView(gameViewModel: gameViewModel))
                            NavigationLink("Design", destination: PaletteLevelsView(paletteViewModel: paletteViewModel))
                        }
                    }
                    .navigationViewStyle(StackNavigationViewStyle())
                    .padding(.all)

                    Spacer()
                }
                .task {
                    paletteViewModel.updateGameArea(geometry.size)
                    paletteViewModel.loadLevelsName()
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
