//
//  Velocity.swift
//  Peggle
//
//  Created by Lee Yong Ler on 5/2/23.
//

import Foundation

struct Vector {
    var x: CGFloat
    var y: CGFloat
    
    private func applyAccelerationHelper(initial: CGFloat, acceleration: CGFloat, time: Float) -> CGFloat {
        return initial + acceleration * CGFloat(time)
    }
    
    mutating func applyAcceleration(acceleration: Acceleration, time: Float) {
        x = applyAccelerationHelper(initial: x, acceleration: acceleration.x, time: time)
        y = applyAccelerationHelper(initial: y, acceleration: acceleration.y, time: time)
    }
    
    func move(centre: CGPoint, time: Float) -> CGPoint {
        let newCentreX = centre.x + self.x * CGFloat(time)
        let newCentreY = centre.y + self.y * CGFloat(time)
        
        return CGPoint(x: newCentreX, y: newCentreY)
    }
}
