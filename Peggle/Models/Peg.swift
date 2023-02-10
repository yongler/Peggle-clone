//
//  Peg.swift represents peggle pegs. 
//  Peggle
//
//  Created by Lee Yong Ler on 24/1/23.
//

import Foundation

struct Peg: Equatable, Codable, Identifiable {
    static let defaultPegRadius: CGFloat = 25
    
    var id = UUID()
    var color: String
    var centre: CGPoint
    var radius: CGFloat
    var isLit = false

    mutating func lightUp() {
        self.isLit = true
    }
    
    mutating func moveCentre(by: CGSize) {
        centre.x += by.width
        centre.y += by.height
    }
}

extension Peg {
    static let sampleBluePeg1 = Peg(color: "peg-blue", centre: CGPoint(x: 350, y: 350), radius: 25)
    static let sampleBluePeg2 = Peg(color: "peg-blue", centre: CGPoint(x: 400, y: 400), radius: 25)
    static let sampleOrangePeg1 = Peg(color: "peg-orange", centre: CGPoint(x: 450, y: 450), radius: 25)
    static let sampleOrangePeg2 = Peg(color: "peg-orange", centre: CGPoint(x: 700, y: 700), radius: 25)
}
