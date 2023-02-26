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
            PaletteDesignButtonView(paletteViewModel: paletteViewModel, selectedButton: .bluePeg)
            PaletteDesignButtonView(paletteViewModel: paletteViewModel, selectedButton: .orangePeg)
            PaletteDesignButtonView(paletteViewModel: paletteViewModel, selectedButton: .kaboom)
            PaletteDesignButtonView(paletteViewModel: paletteViewModel, selectedButton: .spooky)
            PaletteDesignButtonView(paletteViewModel: paletteViewModel, selectedButton: .zombie)
            PaletteDesignButtonView(paletteViewModel: paletteViewModel, selectedButton: .confusement)
            PaletteDesignButtonView(paletteViewModel: paletteViewModel, selectedButton: .block)

            VStack {
                HStack {
                    Text("Resize")
//                    Slider(value: $paletteViewModel.resize, in: 0...360,  onEditingChanged: paletteViewModel.resize())
                }
                HStack {
                    Text("Rotate")
                    Slider(value: $paletteViewModel.rotation, in: 0...360)
                }
            }

            PaletteDesignButtonView(paletteViewModel: paletteViewModel, selectedButton: .delete)
        }
    }
}

struct PaletteDesignButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        PaletteDesignButtonsView(paletteViewModel: PaletteViewModel())
    }
}
