//
//  BucketView.swift
//  Peggle
//
//  Created by Lee Yong Ler on 25/2/23.
//

import SwiftUI

struct BucketView: View {
    @ObservedObject var gameViewModel: GameViewModel
    
    var body: some View {
        Image(gameViewModel.bucketImage)
            .resizable()
            .frame(width: gameViewModel.bucketWidth, height: gameViewModel.bucketHeight)
            .position(gameViewModel.bucketPosition)
            .task {
                gameViewModel.getBucketPosition()
            }
    }
}

struct BucketView_Previews: PreviewProvider {
    static var previews: some View {
        BucketView(gameViewModel: GameViewModel())
    }
}
