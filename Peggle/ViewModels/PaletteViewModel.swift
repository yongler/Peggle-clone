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
    let overwriteSampleBoardWarning = "Overwriting sample boards are not allowed, try with another name"
    
    var defaultBallPosition: CGPoint = CGPoint()
    
    var sampleBoardNames: [String] = []
    var gameArea: CGSize =  CGSize()
    var gameAreaQuarterWidth: CGFloat { gameArea.width / 4 }
    var gameAreaThreeQuarterWidth: CGFloat { gameArea.width * 3 / 4 }
    var gameAreaQuarterHeight: CGFloat { gameArea.height / 4 }
    var gameAreaMidHeight: CGFloat { gameArea.height / 2 }
    
    enum PaletteButtonEnum: String {
        case bluePeg = "peg-blue"
        case orangePeg = "peg-orange"
        case block = "block"
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
            if sampleBoardNames.contains(levelName) {
                print("is sample board but can save")
                alertMessage = overwriteSampleBoardWarning
                hasAlert = true
                return
            }
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

    
    func onTapBackground(location: CGPoint) {
        guard selectedButton != .delete else {
            return
        }
        
        switch selectedButton {
        case .bluePeg:
            board.addPeg(pegType: .blue, centre: location, power: .nopower)
        case .orangePeg:
            board.addPeg(pegType: .orange, centre: location, power: .nopower)
        case .block:
            let block = RectangleBlock(centre: location)
            print("add block")
            board.addBlock(block: block)
        default:
            return
        }
    }
    
    private func addSampleBoard(board: Board, name: String) {
        do {
            guard !boardNames.contains(name) && !sampleBoardNames.contains(name) else {
                return
            }
            
            boardNames.append(name)
            sampleBoardNames.append(name)
            try BoardStore.saveLevels(boardNames: boardNames)
            try BoardStore.save(board: board, name: name)
        } catch {
            alertMessage = saveBoardFail
            hasAlert = true
        }
    }
    
    private func createEasyBoard(gameArea: CGSize) -> Board {
        let samplePeg1 = Peg(pegType: .blue, centre: CGPoint(x: gameAreaQuarterWidth, y: gameAreaQuarterHeight))
        let samplePeg2 = Peg(pegType: .blue, centre: CGPoint(x: gameAreaQuarterWidth, y: gameAreaMidHeight))
        let samplePeg3 = Peg(pegType: .orange, centre: CGPoint(x: gameAreaThreeQuarterWidth, y: gameAreaQuarterHeight))
        let samplePeg4 = Peg(pegType: .orange, centre: CGPoint(x: gameAreaThreeQuarterWidth, y: gameAreaMidHeight))
        
        let easyBoard = Board(gameArea: gameArea, pegs: [samplePeg1, samplePeg2, samplePeg3, samplePeg4])
        
        return easyBoard
    }
    
    private func createPowerUpBoard(gameArea: CGSize) -> Board {
        let samplePeg1 = Peg(pegType: .blue, centre: CGPoint(x: gameAreaQuarterWidth, y: gameAreaQuarterHeight))
        let samplePeg2 = Peg(pegType: .spooky, centre: CGPoint(x: gameAreaQuarterWidth, y: gameAreaMidHeight), power: .spookyball)
        let samplePeg3 = Peg(pegType: .orange, centre: CGPoint(x: gameAreaThreeQuarterWidth, y: gameAreaQuarterHeight))
        
        let samplePeg4 = Peg(pegType: .kaboom, centre: CGPoint(x: gameAreaThreeQuarterWidth, y: gameAreaMidHeight), power: .kaboom)
        let samplePeg5 = Peg(pegType: .orange, centre: CGPoint(x: gameAreaThreeQuarterWidth + 50 , y: gameAreaMidHeight + 50))
        let samplePeg6 = Peg(pegType: .orange, centre: CGPoint(x: gameAreaThreeQuarterWidth - 50, y: gameAreaMidHeight - 50))
        
        let powerUpBoard = Board(gameArea: gameArea, pegs: [samplePeg1, samplePeg2, samplePeg3, samplePeg4, samplePeg5, samplePeg6])
        
        return powerUpBoard
    }
    
    private func createSpicyPegsBoard(gameArea: CGSize) -> Board {
        let samplePeg1 = Peg(pegType: .zombie, centre: CGPoint(x: gameAreaQuarterWidth, y: gameAreaQuarterHeight))
        let samplePeg2 = Peg(pegType: .confusement, centre: CGPoint(x: gameAreaQuarterWidth, y: gameAreaMidHeight))
        let samplePeg3 = Peg(pegType: .orange, centre: CGPoint(x: gameAreaThreeQuarterWidth, y: gameAreaQuarterHeight))
        let samplePeg4 = Peg(pegType: .orange, centre: CGPoint(x: gameAreaThreeQuarterWidth, y: gameAreaMidHeight))
        
        let spicyPegsBoard = Board(gameArea: gameArea, pegs: [samplePeg1, samplePeg2, samplePeg3, samplePeg4])
        
        return spicyPegsBoard
    }
    
    func addSampleBoards(gameArea: CGSize) {
        let easyBoard = createEasyBoard(gameArea: gameArea)
        let easyBoardName = "Easy Board"
        addSampleBoard(board: easyBoard, name: easyBoardName)
        
        let powerUpBoard = createPowerUpBoard(gameArea: gameArea)
        let powerUpBoardName = "Power Up Board"
        addSampleBoard(board: powerUpBoard, name: powerUpBoardName)
        
        let spicyPegsBoard = createSpicyPegsBoard(gameArea: gameArea)
        let spicyPegsBoardName = "Spicy Pegs Board"
        addSampleBoard(board: spicyPegsBoard, name: spicyPegsBoardName)
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
    
    var boardBlocks: [RectangleBlock] {
        get { return board.blocks }
        set { self.boardBlocks = newValue }
    }
    
    func updateGameArea(_ size: CGSize) {
        gameArea = size
        board.updateGameArea(size)
        defaultBallPosition = CGPoint(x: board.gameArea.width / 2, y: 100)
    }
    
}

