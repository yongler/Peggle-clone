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

    var axes: [Vector] {
        var axes = [Vector]()

        for i in 0..<vertices.count {
            let point1 = Vector(origin: vertices[i])
            let point2 = Vector(origin: vertices[i + 1 == vertices.count ? 0 : i + 1])
            let edge: Vector = point1.subtract(point2)
            let normal: Vector = edge.getNormalizedPerpendicular()
            axes.append(normal)
        }
        return axes
    }

    var vertices: [CGPoint] {
        []
    }

    var isStatic: Bool {
        velocity == Vector.zero && acceleration == Acceleration.zero
    }

    init(centre: CGPoint, velocity: Vector, acceleration: Acceleration) {
        self.centre = centre
        self.velocity = velocity
        self.acceleration = acceleration
    }

    func move(time: Double) {
        centre = velocity.update(centre: centre, time: time)
        velocity = acceleration.update(velocity: velocity, time: time)
    }

    static func == (lhs: PhysicsObject, rhs: PhysicsObject) -> Bool {
        lhs.centre == rhs.centre && lhs.velocity == rhs.velocity
        && lhs.acceleration == rhs.acceleration
    }

    func project(onto axis: Vector) -> Projection {
        var start: CGFloat = axis.dotProduct(point: vertices[0])
        var end: CGFloat = start

        for i in 1..<vertices.count {
            let p: CGFloat = axis.dotProduct(point: vertices[i])
            if p < start {
                start = p
            } else if p > end {
                end = p
            }
        }
        return Projection(start: start, end: end)
    }

    private func isOverlappingHelper(with object: PhysicsObject, axes: [Vector]) -> Bool {
        for i in 0..<axes.count {
            let axis = axes[i]

            let projection1: Projection = self.project(onto: axis)
            let projection2: Projection = object.project(onto: axis)

            if !projection1.isOverlapping(projection: projection2) {
                return false
            }
        }
        return true
    }

    func isOverlapping(with object: PhysicsObject) -> Bool {
        let axes1: [Vector] = self.axes
        let axes2: [Vector] = object.axes

        if isOverlappingHelper(with: object, axes: axes1) {
            return true
        }
        return isOverlappingHelper(with: object, axes: axes2)
    }
}
