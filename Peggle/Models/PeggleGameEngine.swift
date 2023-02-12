//
//  PeggleGameEngine.swift
//  Peggle
//
//  Created by Lee Yong Ler on 5/2/23.
//
import SwiftUI
import Foundation

class PeggleGameEngine: ObservableObject {
    @Published var board: Board
    private var gameEngine = GameEngine()
    var frameDuration: Double = 0

    init() {
        print("init")
        board = Board.sampleGameBoard
    }

    func setupWalls() {
        let wallWidth: CGFloat = 5
        let leftWall = RectangleObject(centre: CGPoint(x: wallWidth / 2, y: board.gameArea.height / 2),
                                       width: wallWidth, height: board.gameArea.height)
        let rightWall = RectangleObject(centre: CGPoint(x: board.gameArea.width - wallWidth / 2,
                                                        y: board.gameArea.height / 2),
                                        width: wallWidth, height: board.gameArea.height)

        gameEngine.addPhysicsObject(object: leftWall)
        gameEngine.addPhysicsObject(object: rightWall)
    }

    func createDisplayLink() {
        let displaylink = CADisplayLink(target: self, selector: #selector(update))
        displaylink.add(to: .current, forMode: RunLoop.Mode.default)
    }

    @objc func update(displaylink: CADisplayLink) {
        frameDuration = Double(displaylink.targetTimestamp - displaylink.timestamp)
        let collidedObjects = gameEngine.moveAll(time: frameDuration)
        updateBoardWithGameEngine(collidedObjects: collidedObjects)
    }

    func launchBall() {
        guard let ball = board.ball else {
            return
        }
        let ballVelocity = Vector(origin: ball.centre,
                                  directionX: (ball.centre.x - board.gameArea.width / 2) * 2,
                                  directionY: ball.centre.y * 2)
        let newBall = Ball(centre: ball.centre, velocity: ballVelocity, acceleration: Acceleration.gravity)

        board.setBall(newBall)

        gameEngine.addPhysicsObject(object: newBall)
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
        gameEngine.addPhysicsObject(object: ball)
    }

    func updateBoardWithGameEngine(collidedObjects: [PhysicsObject]) {
        let newBoard = Board(gameArea: board.gameArea)
        for object in gameEngine.objects {
            if let obj = object as? PegPhysicsObject {
                var peg = obj.getPeg()
                if collidedObjects.contains(object) {
                    peg.lightUp()
                }
                newBoard.addPeg(peg)
            }
            if let obj = object as? Ball {
                newBoard.setBall(obj)

                if newBoard.removeBallIfOutOfBounds() {
                    newBoard.setBall()
                    newBoard.clearAllLitPegs()

                }
            }
        }
        
        self.board = newBoard
        setBoardToGameEngine()
    }

    func save(name: String) throws {
        try BoardStore.save(board: board, name: name)
    }

    func load(name: String) throws -> Board {
        board = try BoardStore.load(name: name)
        return board
    }

    func movePeg(_ peg: Peg, by: CGSize) {
        board.movePeg(peg, by: by)
    }

    func removePeg(at: CGPoint) {
        board.removePeg(at: at)
    }

    func addPeg(color: String, centre: CGPoint, radius: CGFloat = Peg.defaultPegRadius) {
        board.addPeg(color: color, centre: centre, radius: radius)
    }

    func moveBall(by: CGSize) {
        board.moveBall(by: by)
    }

    func updateGameArea(_ gameArea: CGSize) {
        board.updateGameArea(gameArea)
        setupWalls()
        board.setBall()
        setBoardToGameEngine()
        createDisplayLink()
    }

}
