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
    @State private var selectedButton: String = "Yoo"
    private var buttonSize: CGFloat = 80
    
    var body: some View {
        VStack {
            GameView()
            
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
