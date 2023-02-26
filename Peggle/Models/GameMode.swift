//
//  GameMode.swift
//  Peggle
//
//  Created by Lee Yong Ler on 25/2/23.
//

import Foundation

enum GameMode {
    case normalGame
    case beatTheScore
    case siamLeftSiamRight

    static func getIsWin(score: Int, timeLeftInSeconds: Int, board: Board, gameMode: GameMode) -> Bool {
        switch gameMode {
        case .normalGame:
            return board.orangePegsLeftCount == 0 && timeLeftInSeconds > 0
        case .beatTheScore:
            return score >= board.beatTheScore && timeLeftInSeconds > 0
        case .siamLeftSiamRight:
            return board.ballsShotCount >= board.siamLeftSiamRightBallsCount && timeLeftInSeconds > 0
        }
    }

    static func getIsLose(score: Int, timeLeftInSeconds: Int, board: Board, gameMode: GameMode) -> Bool {
        switch gameMode {
        case .normalGame:
            return (board.orangePegsLeftCount != 0 && board.ballsLeftCount == 0) || timeLeftInSeconds <= 0
        case .beatTheScore:
            return score < board.beatTheScore && (board.ballsLeftCount == 0 || timeLeftInSeconds <= 0)
        case .siamLeftSiamRight:
            print("hit count \(board.pegsHitCount)")
            print("shot count \(board.ballsShotCount )")
            print("timeLeftInSeconds \(timeLeftInSeconds)")
            print("board.siamLeftSiamRightBallsCount \(board.siamLeftSiamRightBallsCount)")
            
            return board.ballsShotCount < board.siamLeftSiamRightBallsCount &&
            ( timeLeftInSeconds <= 0 || board.pegsHitCount > 0)
        }
    }

}
