//
//  Board.swift represents a game board.
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
    var gameArea: CGSize = CGSize(width: 1000, height: 1000)
    var pegCount: Int {
        pegs.count
    }

//        init(pegs: [Peg] = [], gameArea: CGSize) {
//            self.pegs = pegs
//            self.gameArea = gameArea
//        }
    
    init(pegs: [Peg] = [], gameArea: CGSize) {
        self.pegs = pegs
        self.gameArea = gameArea
    }
    
    init(pegs: [Peg] = []) {
        
    }

    /// Check if peg to add is a valid position, if yes add to board.
    func addPeg(_ peg: Peg) {
        guard checkValidPosition(peg: peg) else {
            return
        }
        self.pegs.append(peg)
    }
    
    /// Check if peg to add is a valid position, if yes add to board.
    func addPeg(color: String, centre: CGPoint, radius: CGFloat = Peg.defaultPegRadius) {
        let peg = Peg(color: color, centre: centre, radius: radius)
        addPeg(peg)
    }

    func removePeg(_ peg: Peg) {
        self.pegs.removeAll(where: {
            $0 == peg
        })
    }

    /// Removes peg occupying a certain coordinate (x, y).
    func removePeg(at: CGPoint) {
        self.pegs.removeAll(where: {
            let radius = $0.radius
            let distanceBetweenCentres = sqrt(pow($0.centre.x - at.x, 2) + pow($0.centre.y - at.y, 2))
            return distanceBetweenCentres <= radius
        })
    }
    
    func movePeg(_ peg: Peg, by: CGSize) {
        for i in 0..<pegs.count {
            if pegs[i] != peg {
                continue
            }
            pegs[i].moveCentre(by: by)
            
            guard checkValidPosition(peg: pegs[i]) else {
                removePeg(pegs[i])
                return
            }
        }
    }

    func clearBoard() {
        self.pegs = []
    }
    
    func updateGameArea(_ gameArea: CGSize) {
        self.gameArea = gameArea
    }

    /// Compares distance between other peg and current peg with sum of
    ///  their radii. If it is shorter, the pegs overlap and return false.
    private func checkNotOverlappingPeg(peg: Peg) -> Bool {
        for otherPeg in self.pegs {
            if otherPeg == peg {
                continue
            }

            let sumOfTwoRadius = otherPeg.radius + peg.radius
            let distanceBetweenCentres = sqrt(pow(otherPeg.centre.x - peg.centre.x, 2) + pow(otherPeg.centre.y - peg.centre.y, 2))
            if distanceBetweenCentres < sumOfTwoRadius {
                return false
            }
        }
        
        return true
    }

    /// Checks if the current peg is in a valid position.
    func checkValidPosition(peg: Peg) -> Bool {
        return checkNotOverlappingPeg(peg: peg) && checkInArea(peg: peg)
//        return checkNotOverlappingPeg(peg: peg)
    }
    
    /// Compares peg location with area boundary
    func checkInArea(peg: Peg) -> Bool {
        guard peg.centre.x - peg.radius > 0 && peg.centre.x + peg.radius < gameArea.width else {
            return false
        }
        guard peg.centre.y - peg.radius > 0 && peg.centre.y + peg.radius < gameArea.height else {
            return false
        }
        return true
    }

}

extension Board {
    static var sampleBoard = Board(pegs: [Peg.sampleBluePeg1, Peg.sampleBluePeg2,
                                          Peg.sampleOrangePeg1, Peg.sampleOrangePeg2])
                                          
}
