//
//  GamePegView.swift
//  Peggle
//
//  Created by Lee Yong Ler on 28/1/23.
//

import SwiftUI

struct GamePegView: View {
    @ObservedObject var gameViewModel: GameViewModel
    @Binding var peg: Peg

    var body: some View {
        Image(ImageViewModel.getPegImage(peg))
            .resizable()
            .frame(width: peg.radius * 2, height: peg.radius * 2)
            .position(peg.centre)
    }
}

struct GamePegView_Previews: PreviewProvider {
    static var previews: some View {
        GamePegView(gameViewModel: GameViewModel(), peg: .constant(Peg.sampleBluePeg1))
    }
}
