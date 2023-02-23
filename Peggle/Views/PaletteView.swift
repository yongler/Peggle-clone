//
//  PaletteView.swift
//  Peggle
//
//  Created by Lee Yong Ler on 24/1/23.
//

import SwiftUI

struct PaletteView: View {
    @StateObject var paletteViewModel: PaletteViewModel

    var body: some View {
        VStack {
            PaletteBoardView(paletteViewModel: paletteViewModel)
            PaletteDesignButtonsView(paletteViewModel: paletteViewModel)
            PaletteActionButtonsView(paletteViewModel: paletteViewModel)
        }
        .padding()
    }
}

struct PaletteView_Previews: PreviewProvider {
    static var previews: some View {
        PaletteView(paletteViewModel: PaletteViewModel())
    }
}
