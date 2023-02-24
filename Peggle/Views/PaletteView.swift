//
//  PaletteView.swift
//  Peggle
//
//  Created by Lee Yong Ler on 24/1/23.
//

import SwiftUI

struct PaletteView: View {
    @ObservedObject var paletteViewModel: PaletteViewModel
    @State var boardName: String?

    var body: some View {
        VStack {
            PaletteBoardView(paletteViewModel: paletteViewModel)
            PaletteDesignButtonsView(paletteViewModel: paletteViewModel)
            PaletteActionButtonsView(paletteViewModel: paletteViewModel)
        }
        .padding()
        .task {
            guard let name = boardName else {
                paletteViewModel.clearBoard()
                return
            }
            paletteViewModel.loadLevel(name: name)
        }
    }
}

struct PaletteView_Previews: PreviewProvider {
    static var previews: some View {
        PaletteView(paletteViewModel: PaletteViewModel(), boardName: ("hello"))
    }
}
