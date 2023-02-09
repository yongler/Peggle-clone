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
    var frameDuration: Float = 0
    
    func createDisplayLink() {
        let displaylink = CADisplayLink(target: self, selector: #selector(update))
        displaylink.add(to: .current, forMode: RunLoop.Mode.default)
    }
    
    @objc func update(displaylink: CADisplayLink) {
        frameDuration = Float(displaylink.targetTimestamp - displaylink.timestamp)
        moveAll()
    }
    
    var objects: [Object] = []
    
    func move(object: Object) {
        guard let object = object as? MoveableObject else {
            return
        }
        guard let index = objects.firstIndex(where: {$0 == object}) else {
            return
        }
        objects[index].move(time: frameDuration)
    }

    func moveAll() {
        for object in objects {
            move(object: object)
        }
    }

}
