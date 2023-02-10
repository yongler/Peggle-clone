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
    var frameDuration: Double = 0
    
    func createDisplayLink() {
        let displaylink = CADisplayLink(target: self, selector: #selector(update))
        displaylink.add(to: .current, forMode: RunLoop.Mode.default)
    }
    
    @objc func update(displaylink: CADisplayLink) {
        frameDuration = Double(displaylink.targetTimestamp - displaylink.timestamp)
        moveAll(time: frameDuration)
   
    }
    
    var objects = [PhysicsObject]()
    
    func addPhysicsObject(object: PhysicsObject) {
        objects.append(object)
    }
    
    func removePhysicsObject(object: PhysicsObject) {
        objects.removeAll(where: {$0 == object})
    }
    
    func move(object: PhysicsObject, time: Double) {
        guard let index = objects.firstIndex(where: {$0 == object}) else {
            return
        }
        print("yo")
        objects[index].move(time: time)
    }

    func moveAll(time: Double) {
        
        for object in objects {
            move(object: object, time: time)
        }
    }

}
