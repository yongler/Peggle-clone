//
//  PeggleGameEngine.swift
//  Peggle
//
//  Created by Lee Yong Ler on 5/2/23.
//

import SwiftUI
import Foundation

class PeggleGameEngine: ObservableObject {
    var board: Board
//    var boardObjectToPhysicsObjectMapping: [NSObject: PhysicsObject] = [:]
    private var gameEngine = GameEngine()
    let collision = Collision()

    var score: Int = 0
    var isWin = false
    var isLose = false
    var gameModeSelected: GameMode = .normalGame
    var timeLeftInSeconds: Int = 0

    let timeForPrematureRemoval: Double = 1
    var launchedBall = false
    var lastBallPosition: CGPoint
    var timeAtLastBallPosition: Double

    var isLucky = false
    var randomInt = Int.random(in: 1...1_000_000)

    var currentTime: Double {
        Double(Calendar.current.component(.second, from: Date()))
    }

    func setGameMode(_ gameMode: GameMode) {
        gameModeSelected = gameMode
    }

//    var timer:
//    var orangePegsHitCount: Int = 0

    init() {
        board = Board.sampleGameBoard
        lastBallPosition = CGPoint(x: 0, y: 0)
        timeAtLastBallPosition = Double(Calendar.current.component(.second, from: Date()))
//        boardObjectToPhysicsObjectMapping[Peg]
        timeLeftInSeconds = board.timeInSeconds
    }

    /// Adds walls
    func setupWalls() {
        let wallWidth: CGFloat = 50
        let wallDisplacement: CGFloat = 100
        let leftWall = RectanglePhysicsObject(centre: CGPoint(x: -wallDisplacement, y: board.gameArea.height / 2),
                                              width: wallWidth, height: board.gameArea.height)

        let rightWall = RectanglePhysicsObject(centre: CGPoint(x: board.gameArea.width + wallDisplacement,
                                                               y: board.gameArea.height / 2),
                                               width: wallWidth, height: board.gameArea.height)

        let topWall = RectanglePhysicsObject(centre: CGPoint(x: board.gameArea.width / 2, y: -wallDisplacement),
                                             width: board.gameArea.width, height: wallWidth)

        gameEngine.addPhysicsObject(object: leftWall)
        gameEngine.addPhysicsObject(object: rightWall)
        gameEngine.addPhysicsObject(object: topWall)
    }

    func setTimeLeftInSeconds(_ timeInSeconds: Int) {
        self.timeLeftInSeconds = timeInSeconds
    }

    func checkWinLose() {
        isWin = GameMode.getIsWin(score: score, timeLeftInSeconds: timeLeftInSeconds,
                                  board: board, gameMode: gameModeSelected)
        isLose = GameMode.getIsLose(score: score, timeLeftInSeconds: timeLeftInSeconds,
                                    board: board, gameMode: gameModeSelected)
    }

    func luckyGetBalls() {

    }

    func update(frameDuration: Double) -> Board {
        isLucky = false
        let collidedObjects = gameEngine.moveAll(time: frameDuration)
        updateBoardWithGameEngine(collidedObjects: collidedObjects)
        setBoardToGameEngine()
        checkWinLose()

//        print("in engine \(board.ball?.powerUps )")
//        print("in engine left \(board.orangePegsLeftCount )")
        return board
    }

    func launchBall(angle: Angle) {
        guard launchedBall == false else {
            return
        }

        board.ballsLeftCount -= 1

        launchedBall = true
        guard let ball = board.ball else {
            return
        }
//        print("hello \(cos(CGFloat(angle.radians)) * 500) \(-sin(CGFloat(angle.radians)) * 500)")
        let ballVelocity = Vector(origin: ball.centre,
                                  directionX: -sin(CGFloat(angle.radians)) * 500,
                                  directionY: cos(CGFloat(angle.radians)) * 500)

        let newBallPhysicsObject = BallPhysicsObject(ball: ball, centre: ball.centre,
                                                     velocity: ballVelocity, acceleration: Acceleration.gravity)

//        board.setBall(newBall)
//        print("launched \(newBallPhysicsObject)")
//        print("objects \(gameEngine.objects)"
        gameEngine.addPhysicsObject(object: newBallPhysicsObject)
//
//        for obj in gameEngine.objects {
//            if obj is BallPhysicsObject {
//                print(obj)
//            }
//        }
    }

    func setBoardToGameEngine() {
        guard let ball = board.ball else {
            return
        }

        var ballPhysicsObject = BallPhysicsObject(ball: ball)
        var bucketPhysicsObject = BucketPhysicsObject(bucket: board.bucket)

        for obj in gameEngine.objects {
            if let ballObject = obj as? BallPhysicsObject {
                if ballObject.acceleration != Acceleration.zero {
                    ballPhysicsObject = ballObject
                }
            }
            if let bucketObject = obj as? BucketPhysicsObject {
                bucketPhysicsObject = bucketObject
            }
        }

        gameEngine.clearObjects()

        for peg in board.pegs {
            let pegToAdd = PegPhysicsObject(peg: peg)
            gameEngine.addPhysicsObject(object: pegToAdd)
        }
        for block in board.blocks {
            let blockToAdd = BlockPhysicsObject(block: block)
            gameEngine.addPhysicsObject(object: blockToAdd)
        }

        gameEngine.addPhysicsObject(object: ballPhysicsObject)
        gameEngine.addPhysicsObject(object: bucketPhysicsObject)
        setupWalls()
    }

    var isBallInBucket: Bool {
        guard let ball = board.ball else {
            return false
        }
        let xWithin: Bool = ball.centre.x <= board.bucket.rightX && ball.centre.x >= board.bucket.leftX
        let yWithin: Bool = ball.centre.y >= board.bucket.topY && ball.centre.y <= board.bucket.bottomY

        return xWithin && yWithin
    }

    func updateScore(collidedObjects: [PhysicsObject]) {
        let orangePegScore = 1_000
        let otherPegScore = 500

        for obj in collidedObjects {
            if let pegObj = obj as? PegPhysicsObject {

                let peg = pegObj.getPeg()

                if peg.pegType == .orange {
                    score += orangePegScore
                } else {
                    score += otherPegScore
                }
            }

        }
    }

    func updateBoardWithGameEngine(collidedObjects: [PhysicsObject]) {
        var newBoard = Board(gameArea: board.gameArea,
                             ballsCount: board.ballsCount, ballsLeftCount: board.ballsLeftCount)
        var pegPowerUpsObtained = Set<PegPowerEnum>()
        var ballPowerUpsObtained = Set<BallPowerEnum>()
        var spicyPegs = Set<PegTypeEnum>()
        var kaboomPeg: Peg?
        var hasSpooky = false

        updateScore(collidedObjects: collidedObjects)

        print("hello---- collided \(collidedObjects)")

        for object in gameEngine.objects {
            if let obj = object as? PegPhysicsObject {
                var peg = obj.getPeg()
                if collidedObjects.contains(object) {
                    if [PegTypeEnum.confusement, PegTypeEnum.zombie].contains(peg.pegType) {
                        spicyPegs.insert(peg.pegType)
                        print("confusement hitt")
                    }

                    peg.lightUp()
                    pegPowerUpsObtained.insert(peg.power)

                    print("yes \(peg)")
                    print("yes \(peg.pegType)")

                    if peg.power == .spookyball {
                        ballPowerUpsObtained.insert(.spookyball)
                        print("spooky peg hit")
                    }

                    if peg.power == .kaboom {
                        pegPowerUpsObtained.insert(.kaboom)
                        kaboomPeg = peg
                    }

//                    if peg.pegType == .confusement {
//                        spicyPegs.insert(peg.pegType)
//                        print("confusement -as-d-as-d-as-d-as-d")
//                    }

                }
                newBoard.addPeg(peg)
                newBoard.pegsHitCount += 1
            }
            if let obj = object as? BallPhysicsObject {
                var oldBall = obj.getBall()
                oldBall.addPowerUps(powerUps: ballPowerUpsObtained)
                newBoard.setBall(oldBall)

                if !ballPowerUpsObtained.isEmpty {
                    print("update board, obtains = \(ballPowerUpsObtained)")
                }

                if !oldBall.powerUps.isEmpty {
                    print("update board, ball = \(oldBall.powerUps)")
                    print("update board, ball has spooky = \(oldBall.powerUps.contains(.spookyball))")
                    hasSpooky = oldBall.powerUps.contains(.spookyball)
                    print("has spooky \(hasSpooky)")
                }

                if currentTime - timeAtLastBallPosition > timeForPrematureRemoval &&
                    abs(lastBallPosition.x - obj.centre.x + lastBallPosition.y - obj.centre.y) < 1 {
                    newBoard.clearAllLitPegs()
                }

                if abs(lastBallPosition.x - obj.centre.x + lastBallPosition.y - obj.centre.y) > 1 {
                    timeAtLastBallPosition = currentTime
                }

                lastBallPosition = obj.centre

                if newBoard.ballIsOutOfBounds {

                    print("ball \(oldBall.powerUps)")
                    if hasSpooky {
                        newBoard.moveBallToTop()
                        print("-----spooky-----")
                    } else {
                        print("in here \(!(oldBall.powerUps.contains(.spookyball)))")
//                        newBoard.moveBallToTop()
                        newBoard.resetBall()
                        newBoard.clearAllLitPegs()
                        launchedBall = false

                    }

                    if isBallInBucket {
                        newBoard.ballsLeftCount += 1
                    }
                }

            }

            if let obj = object as? BucketPhysicsObject {
                newBoard.bucket = obj.getBucket()
            }
            if let obj = object as? BlockPhysicsObject {
                newBoard.addBlock(block: obj.getBlock())
            }

        }

        if spicyPegs.contains(.confusement) {
            print("confuseeee")
            newBoard.flipBoard()
        }
        if !launchedBall {
            gameEngine.objects.removeAll(where: { $0 is BallPhysicsObject })
        }

        if pegPowerUpsObtained.contains(.kaboom) {
            guard let kaboomPeg = kaboomPeg else {
                return
            }
            newBoard.kaboom(from: kaboomPeg)
        }

        if randomInt == 1 {
            isLucky = true
            newBoard.ballsLeftCount += 1
        }

        self.board = newBoard

    }

    func movePeg(_ peg: Peg, by: CGSize) {
        board.movePeg(peg, by: by)
    }

    func removePeg(at: CGPoint) {
        board.removePeg(at: at)
    }

//    func addPeg(pegType: PegTypeEnum, centre: CGPoint, radius: CGFloat = Peg.defaultPegRadius) {
//        board.addPeg(pegType: pegType, centre: centre, radius: radius)
//    }

    func moveBall(to: CGPoint) {
        board.moveBall(to: to)
    }

    func updateBall(to: CGPoint) {
        board.moveBall(to: to)
        setBoardToGameEngine()
    }

    func setupBucket() {
        gameEngine.addPhysicsObject(object: BucketPhysicsObject(bucket: board.bucket))
    }

    func setup(_ gameArea: CGSize, boardToAssign: Board) {
        board = boardToAssign
        board.updateGameArea(gameArea)
        board.setBucket(gameArea: gameArea)
        board.resetBall()
        setupWalls()
        setupBucket()
        setBoardToGameEngine()

//        print("setup in peggle")
//        print("board \(board)")
//        print("ball \(board.ball)")
    }

}
