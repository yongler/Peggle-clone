//
//  Acceleration.swift
//  Peggle
//
//  Created by Lee Yong Ler on 5/2/23.
//

import Foundation

struct Acceleration: Equatable {
    static let zero = Acceleration(x: 0, y: 0)
    static let gravity = Acceleration(x: 0, y: 9.8)
    
    var x: CGFloat
    var y: CGFloat
    
    private func updateVelocityHelper(initial: CGFloat, acceleration: CGFloat, time: Double) -> CGFloat {
        return initial + acceleration * CGFloat(time)
    }
    
    func update(velocity: Vector, time: Double) -> Vector {
        let velocityX = updateVelocityHelper(initial: velocity.x, acceleration: x, time: time)
        let velocityY = updateVelocityHelper(initial: velocity.y, acceleration: y, time: time)
        return Vector(x: velocityX, y: velocityY)
    }
}
