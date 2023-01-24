//
//  GameView.swift
//  Peggle
//
//  Created by Lee Yong Ler on 24/1/23.
//

import SwiftUI

struct GameView: View {
//    @State var board: Board
    @State var selectedButton: String = "Level name"
    var buttonSize: CGFloat = 80

    var body: some View {
        VStack {
            Image("background")
              .resizable()
              .aspectRatio(contentMode: .fill)
            
            Spacer()
            
            HStack {
                Button(action: {
                    selectedButton = "peg-blue"
                }) {
                    Image("peg-blue")
                      .resizable()
                      .frame(width: buttonSize, height: buttonSize, alignment: .bottomLeading)
                }
                
                Button(action: {
                    selectedButton = "peg-orange"
                }) {
                    Image("peg-orange")
                      .resizable()
                      .frame(width: buttonSize, height: buttonSize, alignment: .bottomLeading)
                }
                Spacer()
                Button(action: {
                    selectedButton = "delete"
                }) {
                    Image("delete")
                      .resizable()
                      .frame(width: buttonSize, height: buttonSize, alignment: .bottomLeading)
                }
                
            }

        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
