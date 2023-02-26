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
    var kaboomPeg: Peg?
    var hasSpooky = false

    var currentTime: Double {
        Double(Calendar.current.component(.second, from: Date()))
    }
    var kaboomRadius: CGFloat {
        200
    }

    func setGameMode(_ gameMode: GameMode) {
        gameModeSelected = gameMode
    }

    var pastCollidedObjects = [PhysicsObject]()

    init() {
        board = Board.sampleGameBoard
        lastBallPosition = CGPoint(x: 0, y: 0)
        timeAtLastBallPosition = Double(Calendar.current.component(.second, from: Date()))
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
                                  board: board, gameMode: gameModeSelected, ballsShotCount: ballsShotCount)
        isLose = GameMode.getIsLose(score: score, timeLeftInSeconds: timeLeftInSeconds,
                                    board: board, gameMode: gameModeSelected, ballsShotCount: ballsShotCount)
    }

    var ballsShotCount: Int = 0

    func update(frameDuration: Double) -> Board {
        isLucky = false

        kaboomPeg = nil
        hasSpooky = false
        pegPowerUpsObtained = Set<PegPowerEnum>()
        ballPowerUpsObtained = Set<BallPowerEnum>()
        spicyPegs = Set<PegTypeEnum>()

        if randomInt == 1 { board.ballsLeftCount += 1 }
        let collidedObjects = gameEngine.moveAll(time: frameDuration)
        updateBoardWithGameEngine(collidedObjects: collidedObjects)
        setBoardToGameEngine()
        checkWinLose()
        return board
    }

    func launchBall(angle: Angle) {
        guard launchedBall == false else {
            return
        }

        board.ballsLeftCount -= 1
        ballsShotCount += 1

        launchedBall = true
        guard let ball = board.ball else {
            return
        }
        let ballVelocity = Vector(origin: ball.centre,
                                  directionX: -sin(CGFloat(angle.radians)) * 500,
                                  directionY: cos(CGFloat(angle.radians)) * 500)

        let newBallPhysicsObject = BallPhysicsObject(ball: ball, centre: ball.centre,
                                                     velocity: ballVelocity, acceleration: Acceleration.gravity)

        gameEngine.addPhysicsObject(object: newBallPhysicsObject)
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
            if pastCollidedObjects.contains(obj) {
                continue
            }

            if let pegObj = obj as? PegPhysicsObject {

                let peg = pegObj.getPeg()

                if peg.pegType == .orange {
                    score += orangePegScore * collidedObjects.count
                } else {
                    score += otherPegScore * collidedObjects.count
                }
            }

        }
    }

    var pegPowerUpsObtained = Set<PegPowerEnum>()
    var ballPowerUpsObtained = Set<BallPowerEnum>()
    var spicyPegs = Set<PegTypeEnum>()

    func updateLastBallPositionAndTime(obj: BallPhysicsObject) {
        if abs(lastBallPosition.x - obj.centre.x + lastBallPosition.y - obj.centre.y) > 1 {
            timeAtLastBallPosition = currentTime
        }

        lastBallPosition = obj.centre
    }

    func checkBallIsStuck(obj: Ball) -> Bool {
        currentTime - timeAtLastBallPosition > timeForPrematureRemoval &&
            abs(lastBallPosition.x - obj.centre.x + lastBallPosition.y - obj.centre.y) < 1
    }

    func updateBoardWithGameEngine(collidedObjects: [PhysicsObject]) {
        var newBoard = Board(gameArea: board.gameArea, balls: board.ballsCount, ballsLeftCount: board.ballsLeftCount)

        updateScore(collidedObjects: collidedObjects)
        pastCollidedObjects.append(contentsOf: collidedObjects)

        for object in gameEngine.objects {
            if let obj = object as? PegPhysicsObject {
                var peg = obj.getPeg()
                if collidedObjects.contains(object) {
                    if PegTypeEnum.confusement == peg.pegType { spicyPegs.insert(peg.pegType) }

                    peg.lightUp()
                    pegPowerUpsObtained.insert(peg.power)

                    if peg.power == .spookyball { ballPowerUpsObtained.insert(.spookyball) }
                    newBoard.pegsHitCount += 1

                    if peg.power == .kaboom {
                        pegPowerUpsObtained.insert(.kaboom)
                        kaboomPeg = peg
                    }
                }
                newBoard.addPeg(peg)
            }

            if let obj = object as? BallPhysicsObject {
                var oldBall = obj.getBall()
                oldBall.addPowerUps(powerUps: ballPowerUpsObtained)
                obj.ball = oldBall
                newBoard.setBall(oldBall)

                if checkBallIsStuck(obj: oldBall) { newBoard.clearAllLitPegs() }

                updateLastBallPositionAndTime(obj: obj)

                if isBallInBucket || (newBoard.ballIsOutOfBounds && !oldBall.powerUps.contains(.spookyball)) {
                    newBoard.resetBall()
                    newBoard.clearAllLitPegs()
                    launchedBall = false
                    if isBallInBucket { newBoard.ballsLeftCount += 1 }
                } else if oldBall.powerUps.contains(.spookyball) {
                    if newBoard.ballIsOutOfBounds {
                        newBoard.moveBallToTop()
                        if let ballTop = newBoard.ball {
                            obj.setBall(ball: ballTop)
                            obj.velocity = Vector(directionX: 0, directionY: 400)
                        }
                    }
                }

            }

            if let obj = object as? BucketPhysicsObject { newBoard.bucket = obj.getBucket() }
            if let obj = object as? BlockPhysicsObject { newBoard.addBlock(block: obj.getBlock()) }
        }

        if spicyPegs.contains(.confusement) { newBoard.flipBoard() }
        if !launchedBall { gameEngine.objects.removeAll(where: { $0 is BallPhysicsObject }) }

        if pegPowerUpsObtained.contains(.kaboom) {
            if let kaboomPeg = kaboomPeg { newBoard.kaboom(from: kaboomPeg) }
        }

        self.board = newBoard
    }

    func movePeg(_ peg: Peg, by: CGSize) {
        board.movePeg(peg, by: by)
    }

    func removePeg(at: CGPoint) {
        board.removePeg(at: at)
    }

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
    }

}
