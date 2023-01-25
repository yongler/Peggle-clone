//
//  Board.swift
//  Peggle
//
//  Created by Lee Yong Ler on 24/1/23.
//

import Foundation

class Board: ObservableObject {
    @Published var pegs: [Peg] = []
    private var vaccum: Vaccum = Vaccum()
    
    init() {
        
    }
    
    init(pegs: [Peg]) {
        self.pegs = pegs
    }
    
    func addPeg(_ peg: Peg) {
        self.pegs.append(peg)
    }
    
    func addPeg(color: String, x: Float, y: Float) {
        let peg = Peg(color: color, x: x, y: y)
        self.pegs.append(peg)
    }
    
    func removePeg(_ peg: Peg) {
        self.pegs.removeAll(where: {
            $0 == peg
        })
    }
    
    func clearBoard() {
        self.pegs = []
    }
    
//    func removePeg(x: Int, y: Int) {
//        self.pegs.removeAll(where: {
//            $0 == peg
//        })
//    }
//
}

extension Board {
    static var bluePeg1 = Peg(color: "peg-blue", x: 500, y: 500)
    static var bluePeg2 = Peg(color: "peg-blue", x: 600, y: 600)
    static var orangePeg1 = Peg(color: "peg-orange", x: 700, y: 700)
    static var orangePeg2 = Peg(color: "peg-orange", x: 800, y: 800)
    
    static var sampleBoard = Board(pegs: [bluePeg1, bluePeg2, orangePeg1, orangePeg2])
}
