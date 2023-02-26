//
//  PaletteBallView.swift
//  Peggle
//
//  Created by Lee Yong Ler on 10/2/23.
//

import SwiftUI

struct PaletteBallView: View {
    @ObservedObject var paletteViewModel: PaletteViewModel

    var body: some View {
        Image(ImageViewModel.ballImage)
            .resizable()
            .frame(width: Ball.defaultBallRadius * 2, height: Ball.defaultBallRadius * 2)
            .position(paletteViewModel.defaultBallPosition)
    }
}

struct PaletteBallView_Previews: PreviewProvider {
    static var previews: some View {
        PaletteBallView(paletteViewModel: PaletteViewModel())
    }
}
