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
    
//    init(board: Board) {
//        self.board = board
//    }
    
    func createDisplayLink() {
        gameEngine.createDisplayLink()
        
        let displaylink = CADisplayLink(target: self, selector: #selector(update))
        displaylink.add(to: .current, forMode: RunLoop.Mode.default)
    }

    @objc func update(displaylink: CADisplayLink) {
        updateBoardWithGameEngine()
    }
    
    func getBoard() -> Board {
        return board
    }
    
    func launchBall(centre: CGPoint) {
        guard board.ball == nil else {
            return
        }
        let ballVelocity = Vector(x: centre.x - board.gameArea.width / 2, y: centre.y)
        let ball = Ball(centre: centre, velocity: ballVelocity, acceleration: Acceleration.gravity)
        
//        board.ball = ball
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
        print(gameEngine.objects.count)
    }
    
    func updateBoardWithGameEngine() {
        let newBoard = Board()
        for object in gameEngine.objects {
            if let obj = object as? PegPhysicsObject {
                newBoard.addPeg(obj.getPeg())
            }
            if let obj = object as? Ball {
                print("helo")
                newBoard.addBall(obj)
            }
            
        }
        self.board = newBoard
        print(self.board.pegs.count)
        print(self.board.ball?.centre ?? "")
    }
    
    
    
    func save(name: String) throws {
        try BoardStore.save(board: board, name: name)
    }
    
    func load(name: String) throws -> Board {
        print("hello")
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
    
}
