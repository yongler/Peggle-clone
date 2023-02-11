//
//  Ball.swift
//  Peggle
//
//  Created by Lee Yong Ler on 5/2/23.
//
//
import Foundation

class Ball: PhysicsObject {
    var radius: CGFloat
    static let defaultBallRadius = CGFloat(25)
    
    init(centre: CGPoint, radius: CGFloat = defaultBallRadius, velocity: Vector, acceleration: Acceleration = Acceleration.gravity) {
        self.radius = radius
        super.init(centre: centre, velocity: velocity, acceleration: acceleration)
    }
    
    func moveCentre(by: CGSize) {
        centre.x += by.width
        centre.y += by.height
    }
}

extension Ball {
    static let sampleBall = Ball(centre: CGPoint(x: 400, y: 100), velocity: Vector(x: 0, y: 0), acceleration: Acceleration.zero)
    static let image = "ball"
}
