//
//  Peg.swift represents peggle pegs. 
//  Peggle
//
//  Created by Lee Yong Ler on 24/1/23.
//

import Foundation

struct Peg: Hashable, Codable, CircleObject {
    static let defaultPegRadius: CGFloat = 25
    
    var color: String
    var centre: CGPoint
    var radius: CGFloat
    var isLit = false

    mutating func litUp() {
        self.isLit = true
    }
    
    mutating func moveCentre(by: CGSize) {
        centre.x += by.width
        centre.y += by.height
    }
}

extension Peg {
    static let sampleBluePeg1 = Peg(color: "peg-blue", centre: CGPoint(x: 300, y: 300), radius: 25)
    static let sampleBluePeg2 = Peg(color: "peg-blue", centre: CGPoint(x: 500, y: 500), radius: 25)
    static let sampleOrangePeg1 = Peg(color: "peg-orange", centre: CGPoint(x: 600, y: 600), radius: 25)
    static let sampleOrangePeg2 = Peg(color: "peg-orange", centre: CGPoint(x: 700, y: 700), radius: 25)
}
