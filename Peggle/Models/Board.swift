//
//  Board.swift
//  Peggle
//
//  Created by Lee Yong Ler on 24/1/23.
//

import Foundation

class Board: ObservableObject, Codable {
    var pegs: [Peg] = []
//    private var vaccum: Vaccum = Vaccum()
    
    init() {
        
    }
    
    init(pegs: [Peg]) {
        self.pegs = pegs
    }
    
    func addPeg(_ peg: Peg) {
        self.pegs.append(peg)
    }
    
    func addPeg(color: String, x: Float, y: Float, size: Float) {
        let peg = Peg(color: color, x: x, y: y, size: size)
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
    
    func checkNotColliding(x: Float, y: Float, size: Float) -> Bool {
        for peg in self.pegs {
            let sumOfTwoRadius = peg.size + size
            let distanceBetweenCentres = sqrt(pow(peg.x-x, 2) + pow(peg.y-y, 2))
            if distanceBetweenCentres < sumOfTwoRadius {
                return true
            }
        }
        return false
    }
    
//    func removePeg(x: Int, y: Int) {
//        self.pegs.removeAll(where: {
//            $0 == peg
//        })
//    }
//
}

extension Board {
    static var bluePeg1 = Peg(color: "peg-blue", x: 500, y: 500, size: 50)
    static var bluePeg2 = Peg(color: "peg-blue", x: 600, y: 600, size: 50)
    static var orangePeg1 = Peg(color: "peg-orange", x: 700, y: 700, size: 50)
    static var orangePeg2 = Peg(color: "peg-orange", x: 800, y: 800, size: 50)
    
    static var sampleBoard = Board(pegs: [bluePeg1, bluePeg2, orangePeg1, orangePeg2])
}
