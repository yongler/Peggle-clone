//
//  PalettePegView.swift
//  Peggle
//
//  Created by Lee Yong Ler on 28/1/23.
//

import SwiftUI

struct PalettePegView: View {
    @ObservedObject var paletteViewModel: PaletteViewModel
    @Binding var peg: Peg

    var body: some View {
        Image(peg.pegType.rawValue)
            .resizable()
            .frame(width: peg.radius * 2, height: peg.radius * 2)
            .position(peg.centre)
            .onLongPressGesture(perform: {
                paletteViewModel.pegOnLongPress(peg)
            })
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        paletteViewModel.pegOnDrag(peg, to: gesture.location)
                    }
            )
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onEnded { gesture in
                        paletteViewModel.pegOnTap(at: gesture.location)
                    }
            )

    }
}

struct PalettePegView_Previews: PreviewProvider {
    static var previews: some View {
        PalettePegView(paletteViewModel: PaletteViewModel(), peg: .constant(Peg.sampleBluePeg1))
    }
}
