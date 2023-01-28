//
//  Board.swift
//  Peggle
//
//  Created by Lee Yong Ler on 24/1/23.
//

import Foundation

class Board: Codable, ObservableObject {

    enum CodingKeys: CodingKey {
        case pegs
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        pegs = try container.decode([Peg].self, forKey: .pegs)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(pegs, forKey: .pegs)
    }
  
    @Published var pegs: [Peg] = []
    
    init() {
        
    }
    
    init(pegs: [Peg]) {
        self.pegs = pegs
    }
    
    func addPeg(_ peg: Peg) {
        self.pegs.append(peg)
    }
    
    func addPeg(color: String, x: Float, y: Float, size: Float) {
        guard checkNotColliding(x: x, y: y, size: size) else {
            return
        }
        
        let peg = Peg(color: color, x: x, y: y, size: size)
        self.addPeg(peg)
    }
    
    func removePeg(_ peg: Peg) {
        self.pegs.removeAll(where: {
            $0 == peg
        })
    }
    
    func removePeg(x: Float, y: Float) {
        self.pegs.removeAll(where: {
            let radius = $0.size
            let distanceBetweenCentres = sqrt(pow($0.x-x, 2) + pow($0.y-y, 2))
            return distanceBetweenCentres <= radius
        })
    }
    
    func clearBoard() {
        self.pegs = []
    }
    
    private func checkNotColliding(x: Float, y: Float, size: Float) -> Bool {
        for peg in self.pegs {
            let sumOfTwoRadius = peg.size + size
            let distanceBetweenCentres = sqrt(pow(peg.x-x, 2) + pow(peg.y-y, 2))
            if distanceBetweenCentres < sumOfTwoRadius {
                return false
            }
        }
        
        if x < size || y < size {
            return false
        }
        return true
    }
    
    var pegCount: Int {
        return pegs.count
    }
}


extension Board {
    static var bluePeg1 = Peg(color: "peg-blue", x: 300, y: 300, size: 50)
    static var bluePeg2 = Peg(color: "peg-blue", x: 600, y: 600, size: 50)
    static var orangePeg1 = Peg(color: "peg-orange", x: 700, y: 700, size: 50)
    static var orangePeg2 = Peg(color: "peg-orange", x: 800, y: 800, size: 50)
    
    static var sampleBoard = Board(pegs: [bluePeg1, bluePeg2, orangePeg1, orangePeg2])
}
