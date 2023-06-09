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

    static func getIsWin(score: Int, timeLeftInSeconds: Int, board: Board,
                         gameMode: GameMode, ballsShotCount: Int) -> Bool {
        switch gameMode {
        case .normalGame:
            return board.orangePegsLeftCount == 0 && timeLeftInSeconds > 0
        case .beatTheScore:
            return score >= board.beatTheScore && timeLeftInSeconds > 0
        case .siamLeftSiamRight:
            return ballsShotCount >= board.siamLeftSiamRightBallsCount && timeLeftInSeconds > 0
        }
    }

    static func getIsLose(score: Int, timeLeftInSeconds: Int, board: Board,
                          gameMode: GameMode, ballsShotCount: Int) -> Bool {
        switch gameMode {
        case .normalGame:
            return (board.orangePegsLeftCount != 0 && board.ballsLeftCount == 0) || timeLeftInSeconds <= 0
        case .beatTheScore:
            return score < board.beatTheScore && (board.ballsLeftCount == 0 || timeLeftInSeconds <= 0)
        case .siamLeftSiamRight:
            return ballsShotCount < board.siamLeftSiamRightBallsCount &&
            ( timeLeftInSeconds <= 0 || board.pegsHitCount > 0)
        }
    }

}
