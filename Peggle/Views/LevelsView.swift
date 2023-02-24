//
//  LevelsView.swift
//  Peggle
//
//  Created by Lee Yong Ler on 24/2/23.
//

import SwiftUI

struct LevelsView: View {
    @ObservedObject var paletteViewModel: PaletteViewModel
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink("Create a new level", destination: PaletteView(paletteViewModel: paletteViewModel, boardName: nil))
                
                ForEach(0..<paletteViewModel.boardNames.count, id: \.self) {
                    let boardName = paletteViewModel.boardNames[$0]
                    NavigationLink(boardName, destination: PaletteView(paletteViewModel: paletteViewModel, boardName: boardName))
//                    NavigationLink(boardName, destination: GameBoardView(gameViewModel: gameViewModel, boardName: boardName))
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .task {
            paletteViewModel.loadLevelsName()
        }
    }
}

struct LevelsView_Previews: PreviewProvider {
    static var previews: some View {
        LevelsView(paletteViewModel: PaletteViewModel())
    }
}
