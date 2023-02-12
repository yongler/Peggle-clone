//
//  RectangleObject.swift
//  Peggle
//
//  Created by Lee Yong Ler on 5/2/23.
//

import Foundation

class RectangleObject: PhysicsObject {
    var width: CGFloat
    var height: CGFloat

    override var vertices: [CGPoint] {
        let leftX = centre.x - width / 2
        let rightX = centre.x + width / 2

        let topY = centre.y - height / 2
        let bottomY = centre.y + height / 2

        let topLeftCorner = CGPoint(x: leftX, y: topY)
        let bottomLeftCorner = CGPoint(x: leftX, y: bottomY)
        let topRightCorner = CGPoint(x: rightX, y: topY)
        let bottomRightCorner = CGPoint(x: rightX, y: bottomY)

        return [topLeftCorner, topRightCorner, bottomLeftCorner, bottomRightCorner]
    }

    init(centre: CGPoint, width: CGFloat, height: CGFloat) {
        self.width = width
        self.height = height
        super.init(centre: centre, velocity: Vector.zero, acceleration: Acceleration.zero)
    }
}

extension RectangleObject: CustomStringConvertible {
    var description: String {
        "wall \(centre) \(width) \(height)"
    }
}
