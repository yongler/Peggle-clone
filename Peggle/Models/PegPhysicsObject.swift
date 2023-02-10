//
//  PegPhysicsObject.swift
//  Peggle
//
//  Created by Lee Yong Ler on 9/2/23.
//

import Foundation

class PegPhysicsObject: PhysicsObject {
    var radius: CGFloat
    var peg: Peg
    
    private init(centre: CGPoint, radius: CGFloat, velocity: Vector, acceleration: Acceleration) {
        self.radius = radius
        self.peg = Peg.sampleBluePeg1
        super.init(centre: centre, velocity: velocity, acceleration: acceleration)
    }
    
    convenience init(peg: Peg) {
        self.init(centre: peg.centre, radius: peg.radius, velocity: Vector.zero, acceleration: Acceleration.zero)
        self.peg = peg
    }
    
    func getPeg() -> Peg {
        return Peg(color: peg.color, centre: centre, radius: radius)
    }
}
