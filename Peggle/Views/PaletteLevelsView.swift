//
//  PaletteLevelsView.swift
//  Peggle
//
//  Created by Lee Yong Ler on 24/2/23.
//

import SwiftUI

struct PaletteLevelsView: View {
    @ObservedObject var paletteViewModel: PaletteViewModel

    var body: some View {
        NavigationView {
            List {
                NavigationLink("Create a new level",
                               destination: PaletteView(paletteViewModel: PaletteViewModel(), boardName: nil))

                ForEach(0..<paletteViewModel.boardNames.count, id: \.self) {
                    let boardName = paletteViewModel.boardNames[$0]
                    NavigationLink(boardName,
                                   destination: PaletteView(paletteViewModel: paletteViewModel, boardName: boardName))
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .task {
            paletteViewModel.loadLevelsName()
        }
    }
}

struct PaletteLevelsView_Previews: PreviewProvider {
    static var previews: some View {
        PaletteLevelsView(paletteViewModel: PaletteViewModel())
    }
}
