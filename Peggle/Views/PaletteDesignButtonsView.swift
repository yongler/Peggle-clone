//
//  PaletteButtonsView.swift
//  Peggle
//
//  Created by Lee Yong Ler on 29/1/23.
//

import SwiftUI

struct PaletteDesignButtonsView: View {
    @Binding var selectedButton: String
    var buttonRadius: CGFloat = 80

    var body: some View {
        // 2 peg buttons and 1 delete button.
        HStack {
            Button(action: {
                selectedButton = "peg-blue"
            }) {
                Image("peg-blue")
                  .resizable()
                  .frame(width: buttonRadius,
                         height: buttonRadius, alignment: .bottomLeading)
            }
            .opacity(selectedButton == "peg-blue" ? 1 : 0.5)

            Button(action: {
                selectedButton = "peg-orange"
            }) {
                Image("peg-orange")
                  .resizable()
                  .frame(width: buttonRadius,
                         height: buttonRadius, alignment: .bottomLeading)
            }
            .opacity(selectedButton == "peg-orange" ? 1 : 0.5)

            Spacer()
            Button(action: {
                selectedButton = "delete"
            }) {
                Image("delete")
                  .resizable()
                  .frame(width: buttonRadius,
                         height: buttonRadius, alignment: .bottomLeading)
            }
            .opacity(selectedButton == "delete" ? 1 : 0.5)

        }

    }
}

struct PaletteDesignButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        PaletteDesignButtonsView(selectedButton: .constant(""))
    }
}
