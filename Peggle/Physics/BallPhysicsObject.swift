//
//  BallPhysicsObject.swift
//  Peggle
//
//  Created by Lee Yong Ler on 24/2/23.
//

import Foundation

class BallPhysicsObject: CirclePhysicsObject {
    var ball = Ball.sampleBall
    
    convenience init(ball: Ball) {
        self.init(centre: ball.centre, velocity: Vector.zero, acceleration: Acceleration.zero, radius: ball.radius)
        self.ball = ball
    }
    
    convenience init(ball: Ball, centre: CGPoint,
         velocity: Vector, acceleration: Acceleration, radius: CGFloat = defaultBallRadius) {
        self.init(centre: ball.centre, velocity: velocity, acceleration: acceleration, radius: ball.radius)
        self.ball = ball
    }

    func getBall() -> Ball {
        ball.moveCentre(to: self.centre)
        return ball
    }
}

extension BallPhysicsObject: CustomStringConvertible {
    var description: String {
        "ball \(velocity)"
    }
}
