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
    var boardObjectToPhysicsObjectMapping: [NSObject: PhysicsObject] = [:]
    private var gameEngine = GameEngine()
    let timeForPrematureRemoval: Double = 1

    var launchedBall = false
    var lastBallPosition: CGPoint
    var timeAtLastBallPosition: Double

    var currentTime: Double {
        Double(Calendar.current.component(.second, from: Date()))
    }

    init() {
        board = Board.sampleGameBoard
        lastBallPosition = CGPoint(x: 0, y: 0)
        timeAtLastBallPosition = Double(Calendar.current.component(.second, from: Date()))
//        boardObjectToPhysicsObjectMapping[Peg]
    }

    /// Adds walls
    func setupWalls() {
        let wallWidth: CGFloat = 50
        let wallDisplacement: CGFloat = 100
        let leftWall = RectangleObject(centre: CGPoint(x: -wallDisplacement, y: board.gameArea.height / 2),
                                       width: wallWidth, height: board.gameArea.height)

        let rightWall = RectangleObject(centre: CGPoint(x: board.gameArea.width + wallDisplacement,
                                                        y: board.gameArea.height / 2),
                                        width: wallWidth, height: board.gameArea.height)

        let topWall = RectangleObject(centre: CGPoint(x: board.gameArea.width / 2, y: -wallDisplacement),
                                      width: board.gameArea.width, height: wallWidth)

        gameEngine.addPhysicsObject(object: leftWall)
        gameEngine.addPhysicsObject(object: rightWall)
        gameEngine.addPhysicsObject(object: topWall)
    }

    func update(frameDuration: Double) -> Board {
        let collidedObjects = gameEngine.moveAll(time: frameDuration)
        updateBoardWithGameEngine(collidedObjects: collidedObjects)
        return board
    }

    func launchBall() {
        guard launchedBall == false else {
            return
        }

        launchedBall = true
        guard let ball = board.ball else {
            return
        }
        let ballVelocity = Vector(origin: ball.centre,
                                  directionX: (ball.centre.x - board.gameArea.width / 2) * 5,
                                  directionY: ball.centre.y * 5)
        
        let newBallPhysicsObject = BallPhysicsObject(centre: ball.centre, velocity: ballVelocity, acceleration: Acceleration.gravity)
        

//        board.setBall(newBall)

        gameEngine.addPhysicsObject(object: newBallPhysicsObject)
    }

    func setBoardToGameEngine() {
        gameEngine.clearObjects()

        for peg in board.pegs {
            let pegToAdd = PegPhysicsObject(peg: peg)
            gameEngine.addPhysicsObject(object: pegToAdd)
        }
        guard let ball = board.ball else {
            return
        }
        let ballPhysicsObject = BallPhysicsObject(ball: ball)
        gameEngine.addPhysicsObject(object: ballPhysicsObject)
        setupWalls()
    }

    func updateBoardWithGameEngine(collidedObjects: [PhysicsObject]) {
        var newBoard = Board(gameArea: board.gameArea)
        for object in gameEngine.objects {
            if let obj = object as? PegPhysicsObject {
                var peg = obj.getPeg()
                if collidedObjects.contains(object) {
                    peg.lightUp()
                }
                newBoard.addPeg(peg)
            }
            if let obj = object as? BallPhysicsObject {
                newBoard.setBall(obj.getBall())

                if currentTime - timeAtLastBallPosition > timeForPrematureRemoval &&
                    abs(lastBallPosition.x - obj.centre.x + lastBallPosition.y - obj.centre.y) < 1 {
                    newBoard.clearAllLitPegs()
                }

                if abs(lastBallPosition.x - obj.centre.x + lastBallPosition.y - obj.centre.y) > 1 {
                    timeAtLastBallPosition = currentTime
                }

                lastBallPosition = obj.centre

                if newBoard.removeBallIfOutOfBounds() {
                    newBoard.resetBall()
                    newBoard.clearAllLitPegs()
                    launchedBall = false
                }
            }
        }

        self.board = newBoard
        setBoardToGameEngine()
    }

    
    
    
    
    func movePeg(_ peg: Peg, by: CGSize) {
        board.movePeg(peg, by: by)
    }

    func removePeg(at: CGPoint) {
        board.removePeg(at: at)
    }

//    func addPeg(color: PegTypeEnum, centre: CGPoint, radius: CGFloat = Peg.defaultPegRadius) {
//        board.addPeg(color: color, centre: centre, radius: radius)
//    }

    func moveBall(by: CGSize) {
        board.moveBall(by: by)
    }

    func setup(_ gameArea: CGSize) {
        board.updateGameArea(gameArea)
        setupWalls()
        board.resetBall()
        setBoardToGameEngine()
        print("setup in peggle")
        print("board \(board)")
    }

}
