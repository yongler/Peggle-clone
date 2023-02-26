//
//  Board.swift represents a game board.
//  Peggle
//
//  Created by Lee Yong Ler on 24/1/23.
//

import Foundation

struct Board: Identifiable {
    static let defaultTime = 90

    let id = UUID()
    var pegs: [Peg] = []
    var ball: Ball?
    var bucket = Bucket()
    var blocks: [RectangleBlock] = []
    var ballsCount: Int = 10
    var ballsLeftCount: Int = 10
    var siamLeftSiamRightBallsCount: Int = 5
    var beatTheScore: Int = 10_000

    var gameArea = CGSize(width: 1_000, height: 1_000)
    var pegCount: Int {
        pegs.count
    }
    var pegsHitCount: Int = 0
    var remainingPegsCount: Int {
        var count = 0
        for peg in pegs where !peg.isLit {
            count += 1
        }
        return count
    }

    var orangePegsCount: Int {
        var count = 0
        for peg in pegs where peg.pegType == .orange {
            count += 1
        }
        return count
    }

    var orangePegsLeftCount: Int {
        var count = 0
        for peg in pegs {
            if peg.pegType == .orange && !peg.isLit {
                count += 1
            }
        }
        return count
    }

    var ballsShotCount: Int {
        ballsCount - ballsLeftCount
    }

    var timeInSeconds: Int = Board.defaultTime
//    var boardBlocks: [RectangleBlock] {
//        blocks
//    }

    mutating func kaboom(from: Peg) {
        for i in 0..<pegs.count where from.distanceTo(peg: pegs[i]) <= Peg.kaboomRadius {
            pegs[i].lightUp()
        }
    }

    init(gameArea: CGSize, pegs: [Peg] = [], ballsCount: Int = 10,
         ballsLeftCount: Int = 10, blocks: [RectangleBlock] = []) {
        self.pegs = pegs
        self.gameArea = gameArea
        self.ballsCount = ballsCount
        self.ballsLeftCount = ballsLeftCount
        self.blocks = blocks
    }

    init(pegs: [Peg] = [], ball: Ball? = nil, blocks: [RectangleBlock] = []) {
        self.pegs = pegs
        self.ball = ball
        self.ballsLeftCount = ballsCount
        self.blocks = blocks
    }

    mutating func flipBoard() {
        print("flipp \(gameArea.height / 2) ")
        for i in 0..<pegs.count {
            print("before \(pegs[i])")
            pegs[i].flip(centreAxisXValue: gameArea.height / 2)
            print("after \(pegs[i])")
        }
    }

    mutating func setBucket(gameArea: CGSize) {
        bucket.centre = CGPoint(x: gameArea.width / 2, y: gameArea.height - bucket.height / 2)
    }

    /// Check if peg to add is a valid position, if yes add to board.
    mutating func addPeg(_ peg: Peg) {
        guard checkValidPosition(peg: peg) else {
            return
        }
        self.pegs.append(peg)
    }

    /// Check if peg to add is a valid position, if yes add to board.
    mutating func addPeg(pegType: PegTypeEnum, centre: CGPoint,
                         power: PegPowerEnum, radius: CGFloat = Peg.defaultPegRadius) {
        let peg = Peg(pegType: pegType, centre: centre, radius: radius, power: power)
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

    mutating func removeBlock(at: CGPoint) {
        self.blocks.removeAll(where: {
            $0.containsPoint(at)
        })
    }

    /// Move peg by the specifiied size
    mutating func movePeg(_ peg: Peg, to: CGPoint) {
        let oldCentre = peg.centre

        for i in 0..<pegs.count {
            if pegs[i] != peg {
                continue
            }
            pegs[i].moveCentre(to: to)

            guard checkValidPosition(peg: pegs[i]) else {
                pegs[i].centre = oldCentre
                return
            }
        }
    }

    /// Move peg by the specifiied size
    mutating func movePeg(_ peg: Peg, by: CGSize) {
        let oldCentre = peg.centre

        for i in 0..<pegs.count {
            if pegs[i] != peg {
                continue
            }
            pegs[i].moveCentre(by: by)

            guard checkValidPosition(peg: pegs[i]) else {
                pegs[i].centre = oldCentre
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
    mutating func resetBall() {
        setBall(Ball(centre: CGPoint(x: gameArea.width / 2, y: 100)))
//        print("\(board.ball)")
    }

    mutating func moveBallToTop() {
        ball?.moveToTop()
    }

    mutating func removeBall() {
        self.ball = nil
    }

    var ballIsOutOfBounds: Bool {
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

    mutating func moveBall(to: CGPoint) {
        ball?.moveCentre(to: to)
    }

    mutating func moveBall(by: CGSize) {
//        guard var ball = ball else {
//            return
//        }
////        guard self.ball != nil else {
//            return
//        }
//        guard ball.velocity == Vector.zero && ball.acceleration == Acceleration.zero else {
//            return
//        }
        ball?.moveCentre(by: by)
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

    mutating func addBlock(block: RectangleBlock) {
        blocks.append(block)
//        print("in board \(blocks)")
    }

}

extension Board {
    static var sampleBoard = Board(pegs: [Peg.sampleBluePeg1, Peg.sampleBluePeg2,
                                          Peg.sampleOrangePeg1, Peg.sampleOrangePeg2], ball: Ball.sampleBall)

    static var sampleGameBoard =
        Board(pegs: [
//            Peg.sampleBluePeg1,
//            Peg.sampleBluePeg2,
//            Peg.sampleBluePeg3,
//            Peg.sampleBluePeg4,
//            Peg.sampleBluePeg5,
            Peg.sampleOrangePeg1,
            Peg.sampleOrangePeg2,
            Peg.sampleOrangePeg3,
            Peg.sampleOrangePeg4
//            Peg.sampleOrangePeg5
        ], ball: Ball.sampleBall, blocks: [RectangleBlock.sampleBlock])

}
