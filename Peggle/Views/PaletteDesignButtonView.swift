//
//  PaletteDesignButtonView.swift
//  Peggle
//
//  Created by Lee Yong Ler on 22/2/23.
//

import SwiftUI

struct PaletteDesignButtonView: View {
    @ObservedObject var paletteViewModel: PaletteViewModel
    @State var selectedButton: PaletteViewModel.PaletteButtonEnum
    var buttonRadius: CGFloat = 60

    var body: some View {
        Button(action: {
            paletteViewModel.select(selectedButton)
        }) {
            Image(paletteViewModel.getImage(selectedButton))
              .resizable()
              .frame(width: buttonRadius,
                     height: buttonRadius, alignment: .bottomLeading)
        }
        .opacity(paletteViewModel.getOpacity(selectedButton))
    }
}

struct PaletteDesignButtonView_Previews: PreviewProvider {
    static var previews: some View {
        PaletteDesignButtonView(paletteViewModel: PaletteViewModel(), selectedButton: .bluePeg)
    }
}
