//
//  BackgroundView.swift
//  Peggle
//
//  Created by Lee Yong Ler on 26/2/23.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        Image("background")
            .resizable()
            .background()
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
