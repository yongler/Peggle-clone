//
//  TestView.swift
//  Peggle
//
//  Created by Lee Yong Ler on 11/2/23.
//

import SwiftUI

struct TestView: View {
    @State var isVisible = true
        
    var body: some View {
        
        ZStack {
            Rectangle()
                .zIndex(1)
                .foregroundColor(.blue)
                .gesture(TapGesture(count: 1).onEnded {
                    withAnimation(.easeInOut(duration: 1.0)) {
                        isVisible.toggle()
                    }
                })
            if isVisible {
                Text("Tap me!")
                    .zIndex(2)
            }
        }
        
        
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//
//            .transition(.scale)
//            .onTapGesture {
//                withAnimation(.easeInOut(duration: 0.5)) {
//                   }
//            }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
