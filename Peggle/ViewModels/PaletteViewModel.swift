//
//  PaletteViewModel.swift
//  Peggle
//
//  Created by Lee Yong Ler on 22/2/23.
//

import Foundation

class PaletteViewModel: ObservableObject {
    @Published var selectedButton: PaletteButtonEnum
    @Published var board: Board = Board()
    @Published var levelName: String = ""
    @Published var alertMessage: String = ""
    @Published var hasAlert = false
    
    enum PaletteButtonEnum: String {
        case bluePeg = "peg-blue"
        case orangePeg = "peg-orange"
        case delete = "delete"
    }
    
    init(selectedButton: PaletteButtonEnum) {
        self.selectedButton = selectedButton
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
    
    
    func loadLevel() {
        do {
            board = try BoardStore.load(name: levelName)
        } catch {
            alertMessage = "Failed to load board"
            hasAlert = true
        }
    }
    
    func saveLevel() {
        guard !levelName.isEmpty else {
            alertMessage = "Please specify a name to save"
            hasAlert = true
            return
        }
        do {
            try BoardStore.save(board: board, name: levelName)
        } catch {
            alertMessage = "Failed to save"
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
    
    func pegOnDrag(_ peg: Peg, by: CGSize) {
        board.movePeg(peg, by: by)
    }
    
    func pegOnTap(at: CGPoint) {
        guard selectedButton == .delete else {
            return
        }
        board.removePeg(at: location)
    }
    
    
}
