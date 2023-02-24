//
//  BallPhysicsObject.swift
//  Peggle
//
//  Created by Lee Yong Ler on 24/2/23.
//

import Foundation

class BallPhysicsObject: CircleObject {
    var ball = Ball.sampleBall
    
    convenience init(ball: Ball) {
        self.init(centre: ball.centre, velocity: Vector.zero, acceleration: Acceleration.zero, radius: ball.radius)
        self.ball = ball
    }

    func getBall() -> Ball {
        ball
    }
}

extension BallPhysicsObject: CustomStringConvertible {
    var description: String {
        "ball \(centre) \(velocity) \(acceleration)"
    }
}
