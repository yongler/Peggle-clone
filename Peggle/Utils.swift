//
//  Utils.swift
//  Peggle
//
//  Created by Lee Yong Ler on 28/1/23.
//

import Foundation

struct Utils {

    /// Compares peg location with area boundary
    static func checkInArea(gameArea: CGSize, pegX: Float, pegY: Float, pegRadius: Float) -> Bool {
        guard pegX - pegRadius > 0 && pegX + pegRadius < Float(gameArea.width) else {
            return false
        }
        guard pegY - pegRadius > 0 && pegY + pegRadius < Float(gameArea.height) else {
            return false
        }
        return true
    }
}
