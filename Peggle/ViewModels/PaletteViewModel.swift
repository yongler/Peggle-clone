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

    @Published var resize: Float = 0
    @Published var rotation: Float = 0

    @Published var orangePegsPlacedCount: Int = 0

    func onResize() {
        if let obj = selectedObject as? RectangleBlock {
            for i in 0..<board.blocks.count where board.blocks[i].centre == obj.centre {
                board.blocks[i].scale(by: resize)
            }
        } else if let obj = selectedObject as? Peg {
            for i in 0..<board.pegs.count where board.pegs[i].centre == obj.centre {
                board.pegs[i].scale(by: resize)
            }
        }
    }

    func onRotate() {
        guard let obj = selectedObject as? RectangleBlock else {
            return
        }
        for i in 0..<board.blocks.count where board.blocks[i].centre == obj.centre {
            board.blocks[i].rotationInRadians = CGFloat(rotation * .pi / 180)
        }
    }

    var selectedObject: TransformableObject?

    var defaultBallPosition = CGPoint()

    var sampleBoardNames: [String] = []
    var gameArea = CGSize()
    var gameAreaQuarterWidth: CGFloat { gameArea.width / 4 }
    var gameAreaThreeQuarterWidth: CGFloat { gameArea.width * 3 / 4 }
    var gameAreaQuarterHeight: CGFloat { gameArea.height / 4 }
    var gameAreaMidHeight: CGFloat { gameArea.height / 2 }

    enum PaletteButtonEnum: String {
        case bluePeg = "peg-blue"
        case orangePeg = "peg-orange"
        case kaboom = "peg-green"
        case spooky = "peg-purple"
        case confusement = "peg-yellow"
        case zombie = "peg-red"
        case block = "block"
        case delete = "delete"
    }

    init(selectedButton: PaletteButtonEnum) {
        self.selectedButton = selectedButton
        self.board = Board()
    }

    convenience init() { self.init(selectedButton: .bluePeg) }

    convenience init(boardName: String) {
        self.init(selectedButton: .bluePeg)
        loadLevel(name: boardName)
    }

    func select(_ button: PaletteButtonEnum) { self.selectedButton = button }

    func getOpacity(_ button: PaletteButtonEnum) -> Double { selectedButton == button ? 1 : 0.5 }

    func getImage(_ button: PaletteButtonEnum) -> String { button.rawValue }

    func loadLevel() {
        if !boardNames.contains(levelName) {
            setUpdateMessage(alertMessage: AlertMessages.levelDoesNotExist)
            return
        }

        do {
            board = try BoardStore.load(name: levelName)
        } catch {
            setUpdateMessage(alertMessage: AlertMessages.loadBoardFail)
        }
    }

    func loadLevel(name: String) {
        if !boardNames.contains(name) {
            setUpdateMessage(alertMessage: AlertMessages.levelDoesNotExist)
            return
        }

        levelName = name
        loadLevel()
    }

    func onChangeLevelName(newValue: String) { levelName = newValue }

    func loadLevelsName() {
        do {
            boardNames = try BoardStore.loadLevels()
        } catch {
            setUpdateMessage(alertMessage: AlertMessages.loadLevelsFail)
        }
    }

    func setUpdateMessage(alertMessage: String) {
        self.alertMessage = alertMessage
        hasAlert = true
    }

    func saveLevel() {
        guard !levelName.isEmpty else {
            setUpdateMessage(alertMessage: AlertMessages.emptyLevelName)
            return
        }

        do {
            if sampleBoardNames.contains(levelName) {
                setUpdateMessage(alertMessage: AlertMessages.overwriteSampleBoardWarning)
                return
            }
            if boardNames.contains(levelName) {
                setUpdateMessage(alertMessage: AlertMessages.overwriteWarning)
            } else {
                boardNames.append(levelName)
            }

            try BoardStore.saveLevels(boardNames: boardNames)
            try BoardStore.save(board: board, name: levelName)
        } catch {
            setUpdateMessage(alertMessage: AlertMessages.saveBoardFail)
        }
    }

    func closeAlert() {
        hasAlert = false
    }

    func clearBoard() {
        board.clearBoard()
    }

    func onTapBlock(at: CGPoint) {
        if selectedButton == .delete {
            board.removeBlock(at: at)
            return
        }

        for block in board.blocks where block.containsPoint(at) {
            selectedObject = block
            return
         }
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
            orangePegsPlacedCount += 1
        case .confusement:
            board.addPeg(pegType: .confusement, centre: location, power: .nopower)
        case .spooky:
            board.addPeg(pegType: .spooky, centre: location, power: .nopower)
        case .kaboom:
            board.addPeg(pegType: .kaboom, centre: location, power: .kaboom)
        case .zombie:
            board.addPeg(pegType: .zombie, centre: location, power: .nopower)

        case .block:
            let block = RectangleBlock(centre: location)
            board.addBlock(block: block)
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

    func onLongPressBlock(_ block: RectangleBlock) {
        board.removeBlock(block: block)
    }

    func onDragBlock(_ block: RectangleBlock, to: CGPoint) {
        board.moveBlock(block, to: to)
    }

    func pegOnTap(at: CGPoint) {
        if selectedButton == .delete {
            board.removePeg(at: at)
            return
        }

        for peg in board.pegs where peg.containsPoint(at) {
            selectedObject = peg
            return
         }
    }

    var boardPegs: [Peg] {
        get { board.pegs }
        set { self.boardPegs = newValue }
    }

    var boardBlocks: [RectangleBlock] {
        get { board.blocks }
        set { self.boardBlocks = newValue }
    }

    func updateGameArea(_ size: CGSize) {
        gameArea = size
        board.updateGameArea(size)
        defaultBallPosition = CGPoint(x: board.gameArea.width / 2, y: 100)
    }

}

extension PaletteViewModel {

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
            setUpdateMessage(alertMessage: AlertMessages.saveBoardFail)
        }
    }

    private func createEasyBoard(gameArea: CGSize) -> Board {
        let samplePeg1 = Peg(pegType: .blue, centre: CGPoint(x: gameAreaQuarterWidth, y: gameAreaQuarterHeight))
        let samplePeg2 = Peg(pegType: .blue, centre: CGPoint(x: gameAreaQuarterWidth, y: gameAreaMidHeight))
        let samplePeg3 = Peg(pegType: .orange, centre: CGPoint(x: gameAreaThreeQuarterWidth, y: gameAreaQuarterHeight))
        let samplePeg4 = Peg(pegType: .orange, centre: CGPoint(x: gameAreaThreeQuarterWidth, y: gameAreaMidHeight))

        let easyBoard = Board(gameArea: gameArea,
                              pegs: [samplePeg1, samplePeg2, samplePeg3, samplePeg4],
                              blocks: [RectangleBlock.sampleBlock])

        return easyBoard
    }

    private func createPowerUpBoard(gameArea: CGSize) -> Board {
        let samplePeg1 = Peg(pegType: .orange,
                             centre: CGPoint(x: gameAreaQuarterWidth, y: gameAreaQuarterHeight))
        let samplePeg2 = Peg(pegType: .spooky,
                             centre: CGPoint(x: gameAreaQuarterWidth, y: gameAreaMidHeight), power: .spookyball)
        let samplePeg3 = Peg(pegType: .orange,
                             centre: CGPoint(x: gameAreaThreeQuarterWidth, y: gameAreaQuarterHeight))

        let samplePeg4 = Peg(pegType: .kaboom,
                             centre: CGPoint(x: gameAreaThreeQuarterWidth, y: gameAreaMidHeight), power: .kaboom)
        let samplePeg5 = Peg(pegType: .orange,
                             centre: CGPoint(x: gameAreaThreeQuarterWidth + 50, y: gameAreaMidHeight + 50))
        let samplePeg6 = Peg(pegType: .orange,
                             centre: CGPoint(x: gameAreaThreeQuarterWidth - 50, y: gameAreaMidHeight - 50))

        let powerUpBoard = Board(gameArea: gameArea,
                                 pegs: [samplePeg1, samplePeg2, samplePeg3, samplePeg4, samplePeg5, samplePeg6])

        return powerUpBoard
    }

    private func createSpicyPegsBoard(gameArea: CGSize) -> Board {
        let samplePeg1 = Peg(pegType: .zombie,
                             centre: CGPoint(x: gameAreaQuarterWidth, y: gameAreaQuarterHeight))
        let samplePeg2 = Peg(pegType: .confusement,
                             centre: CGPoint(x: gameAreaQuarterWidth, y: gameAreaMidHeight))
        let samplePeg3 = Peg(pegType: .orange,
                             centre: CGPoint(x: gameAreaThreeQuarterWidth - 100, y: gameAreaMidHeight - 100))
        let samplePeg4 = Peg(pegType: .orange,
                             centre: CGPoint(x: gameAreaThreeQuarterWidth, y: gameAreaMidHeight))

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

}
