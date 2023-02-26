//
//  Collision.swift
//  Peggle
//
//  Created by Lee Yong Ler on 25/2/23.
//

import Foundation

class Collision {
    private func detectCollisionHelper(for obj1: PhysicsObject, with obj2: PhysicsObject, axes: [Vector]) -> Bool {
        for i in 0..<axes.count {
            let axis = axes[i]

            let projection1: Projection = obj1.project(onto: axis)
            let projection2: Projection = obj2.project(onto: axis)

            if !projection1.isOverlapping(projection: projection2) {
                return false
            }
        }
        return true
    }

    func detectCollision(for obj1: PhysicsObject, with obj2: PhysicsObject) -> Bool {
        let axes1: [Vector] = obj1.axes
        let axes2: [Vector] = obj2.axes

        if detectCollisionHelper(for: obj1, with: obj2, axes: axes1) {
            return true
        }
        return detectCollisionHelper(for: obj1, with: obj2, axes: axes2)
    }
}
