//
//  Velocity.swift
//  Peggle
//
//  Created by Lee Yong Ler on 5/2/23.
//

import Foundation

struct Vector: Equatable {
    var x: CGFloat
    var y: CGFloat
    
    static let zero = Vector(x: 0, y: 0)
    
    func update(centre: CGPoint, time: Double) -> CGPoint {
        let newCentreX = centre.x + self.x * CGFloat(time)
        let newCentreY = centre.y + self.y * CGFloat(time)
        
        return CGPoint(x: newCentreX, y: newCentreY)
    }
}
