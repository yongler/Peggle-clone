//
//  BlockView.swift
//  Peggle
//
//  Created by Lee Yong Ler on 25/2/23.
//

import SwiftUI

struct BlockView: View {
    @Binding var block: RectangleBlock
    
    var body: some View {
        Image(GameViewModel.blockImage)
            .resizable()
            .frame(width: block.width, height: block.height)
            .rotationEffect(Angle(radians: block.rotationInRadians), anchor: .center)
            .position(block.centre)
    }
}

struct BlockView_Previews: PreviewProvider {
    static var previews: some View {
        BlockView(block: .constant(RectangleBlock.sampleBlock))
    }
}
