//
//  GameEngine.swift
//  Peggle
//
//  Created by Lee Yong Ler on 5/2/23.
//
import SwiftUI
import Foundation

class GameEngine {
    static let sharedInstance = GameEngine()
    let normalForceCoefficient = 0.6

    var objects = [PhysicsObject]()

    func addPhysicsObject(object: PhysicsObject) {
        objects.append(object)
    }

    func removePhysicsObject(object: PhysicsObject) {
        objects.removeAll(where: { $0 == object })
    }

    func resolveCollision(_ object1: inout PhysicsObject, _ object2: PhysicsObject) -> PhysicsObject {
        if object2 is PegPhysicsObject {
            object1.velocity.directionX *= -1 * normalForceCoefficient
            object1.velocity.directionY *= -1 * normalForceCoefficient
        }
        if object2 is RectangleObject {
            let top: CGFloat = 100
            if object2.centre.y < top {
                object1.velocity.directionY *= -1 * normalForceCoefficient
            } else {
                object1.velocity.directionX *= -1 * normalForceCoefficient
            }
        }
        return object1
    }

    func collidedObjects(object: PhysicsObject) -> [PhysicsObject] {
        var collidedObjects = [PhysicsObject]()

        for obj in self.objects {
            if object == obj {
                continue
            }
            if object.isOverlapping(with: obj) {
                collidedObjects.append(obj)
            }
        }

        return collidedObjects
    }

    func move(object: PhysicsObject, time: Double) -> [PhysicsObject] {
        guard let index = objects.firstIndex(where: { $0 == object }) else {
            return []
        }
        if objects[index].isStatic {
            return []
        }

        objects[index].move(time: time)
        let collidedObjects = collidedObjects(object: objects[index])
        for obj in collidedObjects {
            objects[index] = resolveCollision(&objects[index], obj)
        }
        return collidedObjects
    }

    func moveAll(time: Double) -> [PhysicsObject] {
        var collidedObjects: [PhysicsObject] = []
        for object in objects {
            let collidedObj = move(object: object, time: time)
            collidedObjects.append(contentsOf: collidedObj)
        }
        return collidedObjects
    }

    func clearObjects() {
        objects = []
    }

}
