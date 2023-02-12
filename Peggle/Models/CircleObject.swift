//
//  CircleObject.swift
//  Peggle
//
//  Created by Lee Yong Ler on 5/2/23.
//

import Foundation

class CircleObject: PhysicsObject {
    var radius: CGFloat
    static let defaultBallRadius = CGFloat(25)
    static let numberOfCircumferencePoints: Int = 16

    init(centre: CGPoint,
         velocity: Vector, acceleration: Acceleration, radius: CGFloat = defaultBallRadius) {
        self.radius = radius
        super.init(centre: centre, velocity: velocity, acceleration: acceleration)
    }
    
    override var vertices: [CGPoint] {
        var vertices: [CGPoint] = []

        for i in 0...CircleObject.numberOfCircumferencePoints {
            let angle = Double(i) / Double(CircleObject.numberOfCircumferencePoints) * Double.pi * 2
            let x = cos(angle) * radius + centre.x
            let y = sin(angle) * radius + centre.y
            let vertex = CGPoint(x: x, y: y)
            vertices.append(vertex)
        }

        return vertices
    }

    static func == (lhs: CircleObject, rhs: PhysicsObject) -> Bool {
        guard let obj = rhs as? CircleObject else {
            return false
        }
        return lhs.centre == obj.centre && lhs.velocity == obj.velocity
        && lhs.acceleration == obj.acceleration && lhs.radius == obj.radius
    }
}
