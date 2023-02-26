//
//  RectangleTransformableObject.swift
//  Peggle
//
//  Created by Lee Yong Ler on 25/2/23.
//

import Foundation

class RectangleTransformableObject: TransformableObject {
    var centre: CGPoint
    var rotationInRadians: CGFloat
    var width: CGFloat
    var height: CGFloat

    var vertices: [CGPoint] {
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

    var verticesAfterRotation: [CGPoint] {
        []
    }

    init(centre: CGPoint, width: CGFloat, height: CGFloat, rotationInRadians: CGFloat = 0) {
        self.width = width
        self.height = height
        self.centre = centre
        self.rotationInRadians = rotationInRadians
    }

    func applyTransform() {

    }

}

extension RectangleTransformableObject: CustomStringConvertible {
    var description: String {
        "RectangleTransformableObject \(centre)"
//        "wall \(centre) \(width) \(height) \(vertices)"
    }
}

//extension RectangleTransformableObject: Codable {
//    
//}
