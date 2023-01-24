//
//  PaletteView.swift
//  Peggle
//
//  Created by Lee Yong Ler on 24/1/23.
//

import SwiftUI

struct PaletteView: View {
    var body: some View {
        VStack {
            HStack {
                Circle()
                    .fill(.blue)
                    .frame(width: 100, height: 100)
                Circle()
                    .fill(.pink)
                    .frame(width: 100, height: 100)
            }
        }
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct PaletteView_Previews: PreviewProvider {
    static var previews: some View {
        PaletteView()
    }
}
