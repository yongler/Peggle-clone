//
//  Peg.swift represents peggle pegs. 
//  Peggle
//
//  Created by Lee Yong Ler on 24/1/23.
//

import Foundation

struct Peg: Hashable, Codable {
    var color: String
    var x: Float
    var y: Float
    var radius: Float
}

extension Peg {
    static let samplePeg = Peg(color: "peg-blue", x: 300, y: 300, radius: 25)
}
