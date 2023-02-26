//
//  ImageViewModel.swift
//  Peggle
//
//  Created by Lee Yong Ler on 27/2/23.
//

import Foundation

struct ImageViewModel {
    static let ballImage: String = "ball"
    static let bucketImage: String = "bucket"
    static let blockImage: String = "block"
    static let cannonImage: String = "cannon"
    static let backgroundImage: String = "background"

    static func getNormalPegImageHelper(_ peg: Peg) -> String {
        switch peg.pegType {
        case .blue:
            return "peg-blue"
        case .blueGlow:
            return "peg-blue-glow"
        case .orange:
            return "peg-orange"
        case .orangeGlow:
            return "peg-orange-glow"
        default:
            return ""
        }
    }
    static func getPowerUpPegImageHelper(_ peg: Peg) -> String {
        switch peg.pegType {
        case .spooky:
            return "peg-purple"
        case .spookyGlow:
            return "peg-purple-glow"
        case .kaboom:
            return "peg-green"
        case .kaboomGlow:
            return "peg-green-glow"
        default:
            return ""
        }
    }
    static func getSpciyPegImageHelper(_ peg: Peg) -> String {
        switch peg.pegType {

        case .confusement:
            return "peg-yellow"
        case .confusementGlow:
            return "peg-yellow-glow"
        case .zombie:
            return "peg-red"
        case .zombieGlow:
            return "peg-red-glow"
        default:
            return ""
        }
    }

    static func getPegImage(_ peg: Peg) -> String {
        if !getNormalPegImageHelper(peg).isEmpty {
            return getNormalPegImageHelper(peg)
        }
        if !getPowerUpPegImageHelper(peg).isEmpty {
            return getPowerUpPegImageHelper(peg)
        }
        if !getSpciyPegImageHelper(peg).isEmpty {
            return getSpciyPegImageHelper(peg)
        }
        return ""
    }
}
