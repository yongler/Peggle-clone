//
//  PaletteView.swift
//  Peggle
//
//  Created by Lee Yong Ler on 24/1/23.
//

import SwiftUI

struct MyButtonStyle: ButtonStyle {

  func makeBody(configuration: Self.Configuration) -> some View {
    configuration.label
      .padding()
      .foregroundColor(.white)
      .background(configuration.isPressed ? Color.red : Color.blue)
      .cornerRadius(8.0)
  }

}

struct PaletteView: View {
    @State private var name: String = "Yoo"
    
    var body: some View {
        VStack {
            GameView()
            HStack {
                Button("LOAD") {
                    print("LOAD")
                }
                Button("SAVE") {
                    print("SAVE")
                }
                Button("RESET") {
                    print("RESET")
                }
                TextField("Level name", text: $name)
                    .border(.secondary)
                
                Button("START") {
                    print("START")
                }
            }
        }
        .padding()
    }
}

struct PaletteView_Previews: PreviewProvider {
    static var previews: some View {
        PaletteView()
    }
}
