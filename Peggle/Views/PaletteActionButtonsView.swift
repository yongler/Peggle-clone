//
//  PaletteActionButtonsView.swift
//  Peggle
//
//  Created by Lee Yong Ler on 29/1/23.
//

import SwiftUI

struct PaletteActionButtonsView: View {
    @ObservedObject var paletteViewModel: PaletteViewModel

    var body: some View {
        HStack {
            Button("LOAD") {
                paletteViewModel.loadLevel()
            }
            Button("SAVE") {
                paletteViewModel.saveLevel()
            }
            .alert(paletteViewModel.alertMessage, isPresented: $paletteViewModel.hasAlert) {
                Button("OK", role: .cancel) {
                    paletteViewModel.closeAlert()
                }
            }

            Button("RESET") {
                paletteViewModel.clearBoard()
            }

            TextField("Level name", text: $paletteViewModel.levelName).border(.secondary)

            Button("START") {
                
                
            }
        }
        .ignoresSafeArea(.keyboard)
    }
}

struct PaletteActionButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        PaletteActionButtonsView(paletteViewModel: PaletteViewModel())
    }
}
