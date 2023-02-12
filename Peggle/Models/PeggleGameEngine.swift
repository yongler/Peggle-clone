//
//  PeggleGameEngine.swift
//  Peggle
//
//  Created by Lee Yong Ler on 5/2/23.
//
import SwiftUI
import Foundation

class PeggleGameEngine: ObservableObject {
    @Published var board: Board = Board.sampleBoard
    private var gameEngine: GameEngine = GameEngine()
    var frameDuration: Double = 0
    
//    init(board: Board) {
//        self.board = board
//    }
    
    func createDisplayLink() {
        let displaylink = CADisplayLink(target: self, selector: #selector(update))
        displaylink.add(to: .current, forMode: RunLoop.Mode.default)
    }

    @objc func update(displaylink: CADisplayLink) {
        frameDuration = Double(displaylink.targetTimestamp - displaylink.timestamp)
        let collidedObjects = gameEngine.moveAll(time: frameDuration)
        updateBoardWithGameEngine(collidedObjects: collidedObjects)
    }
    
//    func getBoard() -> Board {
//        return board
//    }
    
    func launchBall() {
        guard var ball = board.ball else {
            return
        }
        let ballVelocity = Vector(origin: ball.centre, directionX: ball.centre.x - board.gameArea.width/2, directionY: ball.centre.y)
        let newBall = Ball(centre: ball.centre, velocity: ballVelocity, acceleration: Acceleration.gravity)
        ball = newBall
        
        gameEngine.addPhysicsObject(object: ball)
    }
    
    func addBoardToGameEngine() {
        for peg in board.pegs {
            let pegToAdd = PegPhysicsObject(peg: peg)
            gameEngine.addPhysicsObject(object: pegToAdd)
        }
        guard let ball = board.ball else {
            return
        }
        gameEngine.addPhysicsObject(object: ball)
//        print(gameEngine.objects.count)
    }
    
    func updateBoardWithGameEngine(collidedObjects: [PhysicsObject]) {
        let newBoard = Board()
        for object in gameEngine.objects {
            if let obj = object as? PegPhysicsObject {
                var peg = obj.getPeg()
                if collidedObjects.contains(object) {
                    peg.lightUp()
                }
                newBoard.addPeg(peg)
            }
            if let obj = object as? Ball {
//                print("helo")
                newBoard.setBall(obj)
                
                if newBoard.removeBallIfOutOfBounds() {
                    gameEngine.removePhysicsObject(object: object)
                    newBoard.setBall()
                }
            }
        }
        
        newBoard.clearAllLitPegs()
        self.board = newBoard
        
//        print(self.board.pegs.count)
//        print(self.board.ball?.centre ?? "")
    }
    
    
    
    func save(name: String) throws {
        try BoardStore.save(board: board, name: name)
    }
    
    func load(name: String) throws -> Board {
//        print("hello")
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
    }
    
}
