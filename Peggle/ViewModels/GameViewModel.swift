//
//  GameViewModel.swift
//  Peggle
//
//  Created by Lee Yong Ler on 23/2/23.
//

import SwiftUI
import Foundation

class GameViewModel: ObservableObject {
    var peggle: PeggleGameEngine = PeggleGameEngine()
    @Published var board: Board = Board.sampleGameBoard
    var displayLink: CADisplayLink!
    
    
    static let blockImage = "block"
    var boardBlocks: [RectangleBlock] {
        get { return board.blocks }
        set { self.boardBlocks = newValue }
    }
    
    
    var ballsLeftCount: Int {
        board.ballsLeftCount
    }
    
    
    @Published var hasGameEndMessage: Bool = false
    let winMessage = "Yay you win"
    let loseMessage = "Try harder ok"
    
    var gameEndMessage: String {
//        ret   urn winMessage
        if peggle.isWin {
            return winMessage
        }
        if peggle.isLose {
            return loseMessage
        }
        return "What"
    }

    
    
    let bucketImage = "bucket"
    var bucketWidth: CGFloat {
        board.bucket.width
    }
    var bucketHeight: CGFloat {
        board.bucket.height
    }
    @Published var bucketPosition: CGPoint = Bucket.defaultPosition
    
    func getBucketPosition() {
        bucketPosition = board.bucket.centre
    }
    
    
    
    
    let cannonImage = "cannon"
    var cannonWidth: CGFloat {
        board.gameArea.width / 3
    }
    var cannonHeight: CGFloat {
        board.gameArea.height / 6
    }
    var cannonPosition: CGPoint {
        CGPoint(x: board.gameArea.width/2, y: cannonHeight / 2)
    }
    func onDragCannon(to: CGPoint) {
        angle = Angle(radians: -atan((to.x - board.gameArea.width/2) / to.y))
    }
    
    func onStopDragCannon() {
        peggle.launchBall(angle: angle)
    }
    @Published var angle: Angle = .zero
    
    
    
    
    var boardPegs: [Peg] {
        get { return board.pegs }
        set { self.boardPegs = newValue }
    }
    
    init(peggle: PeggleGameEngine, board: Board) {
        self.peggle = peggle
        self.board = board
        
    }
    
    init() {
        
    }
    
    
    
    func setupGame(gameArea: CGSize) {
        if hasGameEndMessage {
            return
        }
        board.setBucket(gameArea: gameArea)
        peggle.setup(gameArea)
        createDisplayLink()
        print("setup")
    }
    
    func createDisplayLink() {
        displayLink = CADisplayLink(target: self, selector: #selector(update))
        displayLink.add(to: .current, forMode: RunLoop.Mode.default)
    }

    @objc func update(displaylink: CADisplayLink) {
        let frameDuration = Double(displaylink.targetTimestamp - displaylink.timestamp)
        board = peggle.update(frameDuration: frameDuration)
        getBucketPosition()
        hasGameEndMessage = peggle.isWin || peggle.isLose
        if hasGameEndMessage {
            endGame()
        }
    }
    
    func endGame() {
        displayLink.remove(from: RunLoop.current, forMode: RunLoop.Mode.common)
        displayLink.remove(from: .current, forMode: RunLoop.Mode.default)
        displayLink.isPaused = true
        displayLink.invalidate()
        displayLink = nil
    }
    
    
    
    
//    func onDragBall(to: CGPoint) {
//        board.moveBall(to: to)
//        peggle.updateBall(to: to)
//    }
//

    
}
