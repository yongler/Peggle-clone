//
//  Board.swift
//  Peggle
//
//  Created by Lee Yong Ler on 24/1/23.
//

import Foundation

class Board: ObservableObject {
    @Published var pegs: [Peg]
    var gameArea: CGRect
    var vaccum: Vaccum
    
    init(pegs: [Peg], gameArea: CGRect, vaccum: Vaccum) {
        self.pegs = pegs
        self.gameArea = gameArea
        self.vaccum = vaccum
    }
    
    
}
