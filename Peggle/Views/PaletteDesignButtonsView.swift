//
//  PaletteButtonsView.swift
//  Peggle
//
//  Created by Lee Yong Ler on 29/1/23.
//

import SwiftUI

struct PaletteDesignButtonsView: View {
    @ObservedObject var paletteViewModel: PaletteViewModel

    var body: some View {
        // 2 peg buttons and 1 delete button.
        HStack {
            PaletteDesignButton(paletteViewModel: paletteViewModel, selectedButton: .bluePeg)
            PaletteDesignButton(paletteViewModel: paletteViewModel, selectedButton: .orangePeg)
            PaletteDesignButton(paletteViewModel: paletteViewModel, selectedButton: .block)
            Spacer()
            PaletteDesignButton(paletteViewModel: paletteViewModel, selectedButton: .delete)
        }
    }
}

struct PaletteDesignButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        PaletteDesignButtonsView(paletteViewModel: PaletteViewModel())
    }
}
