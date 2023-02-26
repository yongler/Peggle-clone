//
//  GameViewModel.swift
//  Peggle
//
//  Created by Lee Yong Ler on 23/2/23.
//

import SwiftUI
import Foundation

class GameViewModel: ObservableObject {
    var peggle = PeggleGameEngine()
    @Published var board = Board.sampleGameBoard
    var displayLink: CADisplayLink!
    var timerObject: Timer!

    var timeLeftInSeconds: Int = 0
    @Published var score: Int = 0
    @Published var timer: String = ""

    @Published var hasNotSelectedGameMode = true

    func selectGameMode(_ gameMode: GameMode) {
        hasNotSelectedGameMode = false
        peggle.setGameMode(gameMode)
    }

    @Published var isLucky = true
    let isLuckyMessage = "Lucky! 1 free ball"

//    func closePopup() {
//        displayLink.isPaused = false
//    }

    @Published var boardNames: [String] = []
    @Published var alertMessage: String = ""
    @Published var hasAlert = false
    let loadBoardFail = "Fail to load board"
    let loadLevelsFail = "Fail to load levels"
    let levelDoesNotExist = "Level does not exist"

    func loadLevel(name: String) {
        if !boardNames.contains(name) {
            alertMessage = levelDoesNotExist
            hasAlert = true
            return
        }
        do {
            board = try BoardStore.load(name: name)
        } catch {
            alertMessage = loadBoardFail
            hasAlert = true
        }
    }

    func loadLevelsName() {
        do {
            boardNames = try BoardStore.loadLevels()
        } catch {
            alertMessage = loadLevelsFail
            hasAlert = true
        }
    }

    static let blockImage = "block"
    var boardBlocks: [RectangleBlock] {
        get { board.blocks }
        set { self.boardBlocks = newValue }
    }

    var ballsLeftCount: Int {
        board.ballsLeftCount
    }
    var orangePegsLeftCount: Int {
        board.orangePegsLeftCount
    }

    @Published var hasGameEndMessage = false
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
        CGPoint(x: board.gameArea.width / 2, y: max(cannonHeight / 2, cannonWidth / 2))
    }
    func onDragCannon(to: CGPoint) {
        angle = Angle(radians: -atan((to.x - board.gameArea.width / 2) / to.y))
    }

    func onStopDragCannon() {
        peggle.launchBall(angle: angle)
    }
    @Published var angle: Angle = .zero

    func closeAlert() {
        hasAlert = false
    }

    var boardPegs: [Peg] {
        get { board.pegs }
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
        peggle = PeggleGameEngine()
        peggle.setup(gameArea, boardToAssign: board)
        createDisplayLink()
        createTimer()
        timeLeftInSeconds = board.timeInSeconds
        print("setup")
    }

    func createDisplayLink() {
        displayLink = CADisplayLink(target: self, selector: #selector(update))
        displayLink.add(to: .current, forMode: RunLoop.Mode.default)

    }

    func createTimer() {
        timerObject = Timer.scheduledTimer(timeInterval: 1, target: self,
                                           selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    }

    @objc func updateTimer() {
        timeLeftInSeconds -= 1
        peggle.setTimeLeftInSeconds(timeLeftInSeconds)
        timer = "\(timeLeftInSeconds / 60): \(timeLeftInSeconds % 60)"
    }

    @objc func update(displaylink: CADisplayLink) {
        let frameDuration = Double(displaylink.targetTimestamp - displaylink.timestamp)
        board = peggle.update(frameDuration: frameDuration)
        getBucketPosition()
        score = peggle.score
        isLucky = peggle.isLucky

        hasGameEndMessage = peggle.isWin || peggle.isLose
        if hasGameEndMessage {
            endGame()
        }
//        if isLucky {
//            displayLink.isPaused = true
//        }
    }

    func endGame() {
//        displayLink.remove(from: .current, forMode: RunLoop.Mode.default)
        displayLink.isPaused = true
//        displayLink.invalidate()
//        displayLink = nil

        timerObject.invalidate()
//        timerObject = nil
    }

//    func onDragBall(to: CGPoint) {
//        board.moveBall(to: to)
//        peggle.updateBall(to: to)
//    }
//

}
