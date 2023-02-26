//
//  BlockView.swift
//  Peggle
//
//  Created by Lee Yong Ler on 25/2/23.
//

import SwiftUI

struct BlockView: View {
    @State var paletteViewModel = PaletteViewModel()
    @Binding var block: RectangleBlock

    var body: some View {
        Image(GameViewModel.blockImage)
            .resizable()
            .frame(width: block.width, height: block.height)
            .rotationEffect(Angle(radians: block.rotationInRadians), anchor: .center)
            .position(block.centre)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onEnded { value in
                        paletteViewModel.onTapBlock(at: value.location)
                    }
            )
    }
}

struct BlockView_Previews: PreviewProvider {
    static var previews: some View {
        BlockView(block: .constant(RectangleBlock.sampleBlock))
    }
}
