//
//  Board.swift represents a game board.
//  Peggle
//
//  Created by Lee Yong Ler on 24/1/23.
//

import Foundation

struct Board {
//    enum CodingKeys: CodingKey {
//        case pegs
//    }
//
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        pegs = try container.decode([Peg].self, forKey: .pegs)
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(pegs, forKey: .pegs)
//    }
//
    var pegs: [Peg] = []
    var ball: Ball?
    
    var gameArea = CGSize(width: 1_000, height: 1_000)
    var pegCount: Int {
        pegs.count
    }

    init(gameArea: CGSize, pegs: [Peg] = []) {
        self.pegs = pegs
        self.gameArea = gameArea
    }

    init(pegs: [Peg] = [], ball: Ball? = nil) {
        self.pegs = pegs
        self.ball = ball
    }

    /// Check if peg to add is a valid position, if yes add to board.
    mutating func addPeg(_ peg: Peg) {
        guard checkValidPosition(peg: peg) else {
            return
        }
        self.pegs.append(peg)
    }

    /// Check if peg to add is a valid position, if yes add to board.
    mutating func addPeg(color: PegTypeEnum, centre: CGPoint, radius: CGFloat = Peg.defaultPegRadius) {
        let peg = Peg(color: color, centre: centre, radius: radius)
        addPeg(peg)
    }

    mutating func removePeg(_ peg: Peg) {
        self.pegs.removeAll(where: {
            $0 == peg
        })
    }

    /// Removes peg occupying a certain coordinate (x, y).
    mutating func removePeg(at: CGPoint) {
        self.pegs.removeAll(where: {
            let radius = $0.radius
            let distanceBetweenCentres = sqrt(pow($0.centre.x - at.x, 2) + pow($0.centre.y - at.y, 2))
            return distanceBetweenCentres <= radius
        })
    }

    /// Move peg by the specifiied size
    mutating func movePeg(_ peg: Peg, by: CGSize) {
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

    /// Find peg
    private func findPeg(peg: Peg) -> Int? {
        pegs.firstIndex(of: peg)
    }

    mutating func lightUp(peg: Peg) {
        guard let index = findPeg(peg: peg) else {
            return
        }
        pegs[index].lightUp()
    }

    mutating func clearBoard() {
        self.pegs = []
    }

    mutating func clearAllLitPegs() {
        var newPegs: [Peg] = []

        for peg in pegs {
            if peg.isLit {
                continue
            }
            newPegs.append(peg)
        }
        self.pegs = newPegs
    }

    mutating func setBall(_ ball: Ball) {
        self.ball = ball
    }

    /// Convenience function to reset ball to top
    mutating func setBall() {
        setBall(Ball(centre: CGPoint(x: gameArea.width / 2, y: 100),
                     velocity: Vector.zero, acceleration: Acceleration.zero))
    }

    mutating func removeBall() {
        self.ball = nil
    }

    private var ballIsOutOfBounds: Bool {
        guard let ball = ball else {
            return false
        }
        return ball.centre.y > gameArea.height
    }

    mutating func removeBallIfOutOfBounds() -> Bool {
        if ballIsOutOfBounds {
            removeBall()
            return true
        }
        return false
    }

    func moveBall(by: CGSize) {
        guard let ball = ball else {
            return
        }
        guard ball.velocity == Vector.zero && ball.acceleration == Acceleration.zero else {
            return
        }
        ball.moveCentre(by: by)
    }

    mutating func updateGameArea(_ gameArea: CGSize) {
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
            let distanceBetweenCentres = sqrt(pow(otherPeg.centre.x - peg.centre.x, 2) +
                                              pow(otherPeg.centre.y - peg.centre.y, 2))
            if distanceBetweenCentres < sumOfTwoRadius {
                return false
            }
        }

        return true
    }

    /// Checks if the current peg is in a valid position.
    func checkValidPosition(peg: Peg) -> Bool {
        checkNotOverlappingPeg(peg: peg) && checkInArea(peg: peg)
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
                                          Peg.sampleOrangePeg1, Peg.sampleOrangePeg2], ball: Ball.sampleBall)

    static var sampleGameBoard = Board(pegs: [
        Peg.sampleBluePeg1,
        Peg.sampleBluePeg2,
        Peg.sampleBluePeg3,
        Peg.sampleBluePeg4,
        Peg.sampleBluePeg5,
        Peg.sampleOrangePeg1,
        Peg.sampleOrangePeg2,
        Peg.sampleOrangePeg3,
        Peg.sampleOrangePeg4,
        Peg.sampleOrangePeg5
    ], ball: Ball.sampleBall)
}
