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

    /// Check if peg to add is a valid position, if yes add to board.
    func addPeg(_ peg: Peg) {
        guard checkValidPosition(peg: peg) else {
            return
        }
        self.pegs.append(peg)
    }

    func removePeg(_ peg: Peg) {
        self.pegs.removeAll(where: {
            $0 == peg
        })
    }

    /// Removes peg occupying a certain coordinate.
    func removePeg(x: Float, y: Float) {
        self.pegs.removeAll(where: {
            let radius = $0.radius
            let distanceBetweenCentres = sqrt(pow($0.x - x, 2) + pow($0.y - y, 2))
            return distanceBetweenCentres <= radius
        })
    }

    func clearBoard() {
        self.pegs = []
    }

    /// Compares distance between other peg and current peg with sum of
    ///  their radii. If it is shorter, the pegs overlap.
    private func checkNotOverlappingPeg(peg: Peg) -> Bool {
        for otherPeg in self.pegs {
            if otherPeg == peg {
                continue
            }

            let sumOfTwoRadius = otherPeg.radius + peg.radius
            let distanceBetweenCentres = sqrt(pow(otherPeg.x - peg.x, 2) + pow(otherPeg.y - peg.y, 2))
            if distanceBetweenCentres < sumOfTwoRadius {
                return false
            }
        }
        return true
    }

    func checkValidPosition(peg: Peg) -> Bool {
        checkNotOverlappingPeg(peg: peg)
    }

    var pegCount: Int {
        pegs.count
    }
}

extension Board {
    static var bluePeg1 = Peg(color: "peg-blue", x: 300, y: 300, radius: Constants.Peg.pegRadius)
    static var bluePeg2 = Peg(color: "peg-blue", x: 600, y: 600, radius: Constants.Peg.pegRadius)
    static var orangePeg1 = Peg(color: "peg-orange", x: 700, y: 700, radius: Constants.Peg.pegRadius)
    static var orangePeg2 = Peg(color: "peg-orange", x: 500, y: 500, radius: Constants.Peg.pegRadius)

    static var sampleBoard = Board(pegs: [bluePeg1, bluePeg2, orangePeg1, orangePeg2])
}
