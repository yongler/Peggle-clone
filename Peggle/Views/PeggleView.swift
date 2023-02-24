//
//  PeggleView.swift
//  Peggle
//
//  Created by Lee Yong Ler on 24/2/23.
//

import SwiftUI

struct PeggleView: View {
    @ObservedObject var paletteViewModel: PaletteViewModel
    
    var body: some View {
        NavigationView {
            NavigationLink("Levels", destination: LevelsView(paletteViewModel: paletteViewModel))
        }
    }
}

struct PeggleView_Previews: PreviewProvider {
    static var previews: some View {
        PeggleView(paletteViewModel: PaletteViewModel())
    }
}
