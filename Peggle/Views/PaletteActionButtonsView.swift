//
//  PaletteActionButtonsView.swift
//  Peggle
//
//  Created by Lee Yong Ler on 29/1/23.
//

import SwiftUI

struct PaletteActionButtonsView: View {
    @ObservedObject var paletteViewModel: PaletteViewModel
    let tempFile = "tempFile"
    @State var start: Bool = false
    
    var body: some View {
//        GeometryReader { geometry in
//            if start {
//                GameBoardView(gameViewModel: GameViewModel(), boardName: tempFile)
//                    .frame(width: geometry.size.width, height: geometry.size.height)
////                    .scaledToFill()
//            } else {
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
//                        start = true
//                        paletteViewModel.saveTemp(name: tempFile)
                    }
                    
            }
           
//            }
//        }
    }
}

struct PaletteActionButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        PaletteActionButtonsView(paletteViewModel: PaletteViewModel())
    }
}
