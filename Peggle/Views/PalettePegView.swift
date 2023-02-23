//
//  PegView.swift
//  Peggle
//
//  Created by Lee Yong Ler on 28/1/23.
//

import SwiftUI

struct PalettePegView: View {
    @ObservedObject var paletteViewModel: PaletteViewModel
    @Binding var peg: Peg
    @State private var dragOffset = CGSize.zero

    var body: some View {
        Image(peg.color.rawValue)
                    .resizable()
                    .frame(width: peg.radius * 2, height: peg.radius * 2)
                    .position(peg.centre)
                    .offset(dragOffset)
                    .onLongPressGesture(perform: {
                        paletteViewModel.pegOnLongPress(peg)
                    })
                    .gesture(
                        DragGesture(minimumDistance: 50)
                            .onChanged { gesture in
                                dragOffset = gesture.translation
                            }
                            .onEnded { gesture in
                                dragOffset = .zero
                                paletteViewModel.pegOnDrag(peg, by: gesture.translation)
                            }
                    )
                    .onTapGesture { location in
                        paletteViewModel.pegOnTap(at: location)
                    }
            }
}

struct PalettePegView_Previews: PreviewProvider {
    static var previews: some View {
        PalettePegView(paletteViewModel: PaletteViewModel(), peg: .constant(Peg.sampleBluePeg1))
    }
}
