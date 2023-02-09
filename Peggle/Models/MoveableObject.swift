//
//  MoveableObject.swift
//  Peggle
//
//  Created by Lee Yong Ler on 5/2/23.
//

import Foundation

class MoveableObject: Object {
    var velocity: Vector
    var acceleration: Acceleration
    
    init(centre: CGPoint, velocity: Vector, acceleration: Acceleration) {
        self.velocity = velocity
        self.acceleration = acceleration
        super.init(centre: centre)
    }
}

extension MoveableObject {
    func move(time: Float) {
        velocity.applyAcceleration(acceleration: acceleration, time: time)
        centre = velocity.move(centre: centre, time: time)
    }
}
