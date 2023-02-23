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
    
    let loadBoardFail = "Fail to load board"
    let emptyLevelName = "Please specify a name to save"
    let saveBoardFail = "Failed to save"
    let levelDoesNotExist = "Level does not exist"
    let overwriteWarning = "Saving will overwrite the existing level"
    
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
    
    func select(_ button: PaletteButtonEnum) {
        self.selectedButton = button
    }
    
    func getOpacity(_ button: PaletteButtonEnum) -> Double {
        return selectedButton == button ? 1 : 0.5
    }
    
    func getImage(_ button: PaletteButtonEnum) -> String {
        return button.rawValue
    }
    
    
//    func loadLevel() {
//        do {
//            board = try BoardStore.load(name: levelName)
//        } catch {
//            alertMessage = loadBoardFail
//            hasAlert = true
//        }
//    }
//
//    func saveLevel() {
//        guard !levelName.isEmpty else {
//            alertMessage = emptyLevelName
//            hasAlert = true
//            return
//        }
//        do {
//            try BoardStore.save(board: board, name: levelName)
//        } catch {
//            alertMessage = saveBoardFail
//            hasAlert = true
//        }
//    }
    
    func closeAlert() {
        hasAlert = false
    }
    
    func clearBoard() {
        board.clearBoard()
    }

    
    func addPeg(location: CGPoint) {
        print("adding peg")
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

    func pegOnDrag(_ peg: Peg, by: CGSize) {
        print("draggging")
        board.movePeg(peg, by: by)
    }

    func pegOnTap(at: CGPoint) {
        print("heiio")
        guard selectedButton == .delete else {
            return
        }
        print("hellooo")
        board.removePeg(at: at)
    }
    
    var boardPegs: [Peg] {
//        get { return board.pegs }
//        set { boardPegs = newValue }
        board.pegs
    }
    
    
}
