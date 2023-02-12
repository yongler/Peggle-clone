//
//  Ball.swift
//  Peggle
//
//  Created by Lee Yong Ler on 5/2/23.
//
//
import Foundation

class Ball: CircleObject {
    var defaultBallRadius = CGFloat(40)

    override init(centre: CGPoint, velocity: Vector,
                  acceleration: Acceleration = Acceleration.gravity, radius: CGFloat = defaultBallRadius) {
        super.init(centre: centre, velocity: velocity, acceleration: acceleration, radius: radius)
    }

    func moveCentre(by: CGSize) {
        centre.x += by.width
        centre.y += by.height
    }

}

extension Ball {
    static let sampleBall = Ball(centre: CGPoint(x: 400, y: 100),
                                 velocity: Vector.zero, acceleration: Acceleration.zero)
    static let image = "ball"
}

extension Ball: CustomStringConvertible {
    var description: String {
        "ball \(centre) \(velocity)"
    }
}
