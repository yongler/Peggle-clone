//
//  Object.swift
//  Peggle
//
//  Created by Lee Yong Ler on 5/2/23.
//

import Foundation

class PhysicsObject: Equatable {
    var centre: CGPoint
    var velocity: Vector
    var acceleration: Acceleration
    
    init(centre: CGPoint, velocity: Vector, acceleration: Acceleration) {
        self.centre = centre
        self.velocity = velocity
        self.acceleration = acceleration
    }
    
    func move(time: Double) {
        print("centre \(centre) new centre \(velocity.update(centre: centre, time: time))")
        print("velocity \(velocity) new velocity \(acceleration.update(velocity: velocity, time: time))")
        
        centre = velocity.update(centre: centre, time: time)
        velocity = acceleration.update(velocity: velocity, time: time)
    }
    
    static func ==(lhs: PhysicsObject, rhs: PhysicsObject) -> Bool {
        return lhs.centre == rhs.centre && lhs.velocity == rhs.velocity
        && lhs.acceleration == rhs.acceleration
    }
}
