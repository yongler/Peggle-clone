//
//  GameView.swift
//  Peggle
//
//  Created by Lee Yong Ler on 24/1/23.
//

import SwiftUI

struct GameView: View {
//    @StateObject var board: Board
    
    var body: some View {
        Image("background")
          .resizable()
          .aspectRatio(contentMode: .fill)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
