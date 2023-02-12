//
//  GameEngine.swift
//  Peggle
//
//  Created by Lee Yong Ler on 5/2/23.
//
import SwiftUI
import Foundation

class GameEngine {
    static let sharedInstance: GameEngine = GameEngine()
//    var frameDuration: Double = 0
    
//    func createDisplayLink() {
//        let displaylink = CADisplayLink(target: self, selector: #selector(update))
//        displaylink.add(to: .current, forMode: RunLoop.Mode.default)
//    }
//
//    @objc func update(displaylink: CADisplayLink) {
//        frameDuration = Double(displaylink.targetTimestamp - displaylink.timestamp)
//        moveAll(time: frameDuration)
//    }
    
    var objects = [PhysicsObject]()
    
    func addPhysicsObject(object: PhysicsObject) {
        objects.append(object)
    }
    
    func removePhysicsObject(object: PhysicsObject) {
        objects.removeAll(where: {$0 == object})
    }
    func resolveCollision(_ object1: PhysicsObject, _ object2: PhysicsObject) {
        
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
        guard let index = objects.firstIndex(where: {$0 == object}) else {
            return []
        }
        if objects[index].isStatic {
            return []
        }
        
        objects[index].move(time: time)
        let collidedObjects = collidedObjects(object: objects[index])
        for obj in collidedObjects {
            print("\(object) collided with \(obj)")
            resolveCollision(objects[index], obj)
        }
        return collidedObjects
    }

    func moveAll(time: Double) -> [PhysicsObject] {
        var collidedObjects: [PhysicsObject] = []
        print("----------------")
        for object in objects {
//            print(object)
            let collidedObj = move(object: object, time: time)
            collidedObjects.append(contentsOf: collidedObj)
        }
        return collidedObjects
    }

}
