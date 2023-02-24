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
    @Published var board: Board = Board()
    
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
    
    func onDragBall(by: CGSize) {
        board.moveBall(by: by)
    }
    
    func onTapBall() {
        peggle.launchBall()
    }
    
}
