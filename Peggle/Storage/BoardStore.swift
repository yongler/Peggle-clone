//
//  BoardStore.swift represents an abstraction to handle loading and saving data.
//  Peggle
//
//  Referenced from https://developer.apple.com/tutorials/app-dev-training/persisting-data
//

import Foundation

class BoardStore: ObservableObject {
    static let allLevelsFileName = "allLevels"

    /// Get file URL from specified file name.
    private static func getFileURL(from name: String) throws -> URL {
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return directory.appendingPathComponent(name).appendingPathExtension(".data")
    }

//    static func loadLevels() throws -> [Board] {
//        let fileURL = try getFileURL(from: allLevelsFileName)
//        guard let file = try? FileHandle(forReadingFrom: fileURL) else {
//            return [Board]()
//        }
//        let allBoards = try JSONDecoder().decode([Board].self, from: file.availableData)
//        return allBoards
//    }

    static func loadLevels() throws -> [String] {
        let fileURL = try getFileURL(from: allLevelsFileName)
        guard let file = try? FileHandle(forReadingFrom: fileURL) else {
            return [String]()
        }
        let allBoards = try JSONDecoder().decode([String].self, from: file.availableData)
        return allBoards
    }

    static func load(name: String) throws -> Board {
        let fileURL = try getFileURL(from: name)
        guard let file = try? FileHandle(forReadingFrom: fileURL) else {
            return Board()
        }
        let board = try JSONDecoder().decode(Board.self, from: file.availableData)
        return board
    }

    static func saveLevels(boardNames: [String]) throws {
        let data = try JSONEncoder().encode(boardNames)
        let outfile = try getFileURL(from: allLevelsFileName)
        try data.write(to: outfile)
    }

    static func save(board: Board, name: String) throws {
        let data = try JSONEncoder().encode(board)
        let outfile = try getFileURL(from: name)
        try data.write(to: outfile)
    }

//    static func save(board: Board) throws {
//        let data = try JSONEncoder().encode(board)
//        let outfile = try getFileURL(from: board.name)
//        try data.write(to: outfile)
//    }

}
