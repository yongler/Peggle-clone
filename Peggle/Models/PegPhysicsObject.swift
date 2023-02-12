//
//  PegPhysicsObject.swift
//  Peggle
//
//  Created by Lee Yong Ler on 9/2/23.
//

import Foundation

class PegPhysicsObject: CircleObject {
    var peg = Peg.sampleBluePeg1

    convenience init(peg: Peg) {
        self.init(centre: peg.centre, velocity: Vector.zero, acceleration: Acceleration.zero, radius: peg.radius)
        self.peg = peg
    }

    func getPeg() -> Peg {
        return peg
    }
}

extension PegPhysicsObject: CustomStringConvertible {
    var description: String {
        "peg \(centre) \(peg.color)"
    }
}
