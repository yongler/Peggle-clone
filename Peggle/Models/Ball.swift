//
//  Ball.swift
//  Peggle
//
//  Created by Lee Yong Ler on 5/2/23.
//
//
import Foundation

struct Ball {
    var centre: CGPoint
    var radius: CGFloat
    static let defaultBallRadius = CGFloat(25)
    
    init(centre: CGPoint, radius: CGFloat = defaultBallRadius) {
        self.centre = centre
        self.radius = radius
    }
    
    mutating func moveCentre(by: CGSize) {
        centre.x += by.width
        centre.y += by.height
    }
    
    mutating func moveCentre(to: CGPoint) {
        centre = to
    }
}

extension Ball {
    static let sampleBall = Ball(centre: CGPoint(x: 400, y: 100), radius: Ball.defaultBallRadius)
    static let image = "ball"
}

extension Ball: CustomStringConvertible {
    var description: String {
        "ball \(centre)"
    }
}
