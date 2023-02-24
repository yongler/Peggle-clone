//
//  PaletteViewModel.swift
//  Peggle
//
//  Created by Lee Yong Ler on 22/2/23.
//

import Foundation

class PaletteViewModel: ObservableObject {
    @Published var selectedButton: PaletteButtonEnum
    @Published var board: Board
    @Published var levelName: String = ""
    @Published var alertMessage: String = ""
    @Published var hasAlert = false
    
    @Published var levels: [Board] = []
    @Published var boardNames: [String] = []
    
    let loadBoardFail = "Fail to load board"
    let loadLevelsFail = "Fail to load levels"
    let emptyLevelName = "Please specify a name to save"
    let saveBoardFail = "Failed to save"
    let levelDoesNotExist = "Level does not exist"
    let overwriteWarning = "Saving will overwrite the existing level"
    
    var defaultBallPosition: CGPoint = CGPoint()
    
    
    enum PaletteButtonEnum: String {
        case bluePeg = "peg-blue"
        case orangePeg = "peg-orange"
        case delete = "delete"
    }
    
    init(selectedButton: PaletteButtonEnum) {
        self.selectedButton = selectedButton
        self.board = Board()
    }
    
    convenience init() {
        self.init(selectedButton: .bluePeg)
    }
    
    convenience init(boardName: String) {
        self.init(selectedButton: .bluePeg)
        loadLevel(name: boardName)
    }
    
    func select(_ button: PaletteButtonEnum) {
        self.selectedButton = button
    }
    
    func getOpacity(_ button: PaletteButtonEnum) -> Double {
        return selectedButton == button ? 1 : 0.5
    }
    
    func getImage(_ button: PaletteButtonEnum) -> String {
        return button.rawValue
    }
    
    func loadLevel() {
        if !boardNames.contains(levelName) {
            alertMessage = levelDoesNotExist
            hasAlert = true
            return
        }
        
        do {
            board = try BoardStore.load(name: levelName)
        } catch {
            alertMessage = loadBoardFail
            hasAlert = true
        }
    }
    
    func loadLevel(name: String) {
        if !boardNames.contains(name) {
            alertMessage = levelDoesNotExist
            hasAlert = true
            return
        }
        
        levelName = name
        loadLevel()
    }
    
    func loadLevelsName() {
        do {
            boardNames = try BoardStore.loadLevels()
        } catch {
            alertMessage = loadLevelsFail
            hasAlert = true
        }
    }

    func saveLevel() {
        guard !levelName.isEmpty else {
            alertMessage = emptyLevelName
            hasAlert = true
            return
        }
        
        do {
            if boardNames.contains(levelName) {
                alertMessage = overwriteWarning
                hasAlert = true
            } else {
                boardNames.append(levelName)
            }
            try BoardStore.saveLevels(boardNames: boardNames)
            try BoardStore.save(board: board, name: levelName)
        } catch {
            alertMessage = saveBoardFail
            hasAlert = true
        }
    }
    
    func closeAlert() {
        hasAlert = false
    }
        
    func clearBoard() {
        board.clearBoard()
    }

    
    func addPeg(location: CGPoint) {
        guard selectedButton != .delete else {
            return
        }
        
        switch selectedButton {
        case .bluePeg:
            board.addPeg(color: .blue, centre: location)
        case .orangePeg:
            board.addPeg(color: .orange, centre: location)
        default:
            return
        }
    }
    
    
    func pegOnLongPress(_ peg: Peg) {
        board.removePeg(peg)
    }

    func pegOnDrag(_ peg: Peg, to: CGPoint) {
        board.movePeg(peg, to: to)
    }

    func pegOnTap(at: CGPoint) {
        guard selectedButton == .delete else {
            return
        }
        board.removePeg(at: at)
    }
    
    var boardPegs: [Peg] {
        get { return board.pegs }
        set { self.boardPegs = newValue }
    }
    
    func updateGameArea(_ size: CGSize) {
        board.updateGameArea(size)
        defaultBallPosition = CGPoint(x: board.gameArea.width / 2, y: 100)
    }
    
}
