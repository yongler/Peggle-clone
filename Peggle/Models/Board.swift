//
//  Board.swift
//  Peggle
//
//  Created by Lee Yong Ler on 24/1/23.
//

import Foundation

class Board: ObservableObject {
    @Published var pegs: [Peg: [[Int]]] = [:]
    private var vaccum: Vaccum = Vaccum()
    
    init() {
        
    }
    
    init(pegs: [Peg: [[Int]]]) {
        self.pegs = pegs
    }
    
    func addPeg(_ peg: Peg, x: Int, y: Int) {
        self.pegs[peg] = pegs[peg] ?? [[Int]]()
        self.pegs[peg]?.append([x,y])
    }
    
    func removePeg(_ peg: Peg, x: Int, y: Int) {
        self.pegs[peg]?.removeAll(where: {
            $0[0] == x && $0[1] == y
        })
    }
    
}

extension Board {
    static var sampleBoard = Board(pegs: [Peg(color: "blue"): [[50, 50], [500, 500]], Peg(color: "orange"): [[50, 50], [500, 500]]])
}
