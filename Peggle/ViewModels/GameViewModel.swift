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
        board.updateGameArea(gameArea)
        board.setBucket(gameArea: gameArea)
        board.resetBall()
        
        peggle.setup(gameArea)
        createDisplayLink()
        print("setup")
    }
    
    func createDisplayLink() {
        let displaylink = CADisplayLink(target: self, selector: #selector(update))
        displaylink.add(to: .current, forMode: RunLoop.Mode.default)
    }

    @objc func update(displaylink: CADisplayLink) {
        let frameDuration = Double(displaylink.targetTimestamp - displaylink.timestamp)
        board = peggle.update(frameDuration: frameDuration)
//        print("update \(board.ball?.centre)")
    }
    
//    func onDragBall(to: CGPoint) {
//        board.moveBall(to: to)
//        peggle.updateBall(to: to)
//    }
//
    func onDragCannon(to: CGPoint) {
        angle = Angle(radians: -atan((to.x - board.gameArea.width/2) / to.y))
    }
    
    
    
    func onStopDragCannon() {
        print("tap")
        peggle.launchBall(angle: angle)
    }

    
}
