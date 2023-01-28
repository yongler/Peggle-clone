//
//  BoardStore.swift
//  Peggle
//
//  Referenced from https://developer.apple.com/tutorials/app-dev-training/modernizing-asynchronous-code
//

import Foundation

class BoardStore: ObservableObject {

    /// Get file URL from specified file name.
    private static func getFileURL(from name: String) throws -> URL {
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return directory.appendingPathComponent(name).appendingPathExtension(".data")
    }

    static func load(name: String) async throws -> Board {
        try await withCheckedThrowingContinuation { continuation in
            load(name: name) { result in
                switch result {
                case .failure(let error):
                    continuation.resume(throwing: error)
                case .success(let board):
                    continuation.resume(returning: board)
                }
            }
        }
    }

    static func load(name: String, completion: @escaping (Result<Board, Error>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let fileURL = try getFileURL(from: name)
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async {
                        completion(.success(Board()))
                    }
                    return
                }
                let board = try JSONDecoder().decode(Board.self, from: file.availableData)
                DispatchQueue.main.async {
                    completion(.success(board))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }

    @discardableResult
    static func save(board: Board, name: String) async throws -> Int {
        try await withCheckedThrowingContinuation { continuation in
            save(board: board, name: name) { result in
                switch result {
                case .failure(let error):
                    continuation.resume(throwing: error)
                case .success(let boardSaved):
                    continuation.resume(returning: boardSaved)
                }
            }
        }
    }

    static func save(board: Board, name: String, completion: @escaping (Result<Int, Error>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(board)
                let outfile = try getFileURL(from: name)
                try data.write(to: outfile)
                DispatchQueue.main.async {
                    completion(.success(board.pegs.count))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
