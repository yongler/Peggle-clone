//
//  RectangleBlock.swift
//  Peggle
//
//  Created by Lee Yong Ler on 25/2/23.
//

import Foundation

struct RectangleBlock: TransformableObject, Identifiable, Equatable {
    static let defaultWidth: CGFloat = 100
    static let defaultHeight: CGFloat = 80

    var id = UUID()
    var centre: CGPoint
    var rotationInRadians: CGFloat
    var width: CGFloat
    var height: CGFloat

    var originalWidth: CGFloat
    var originalHeight: CGFloat

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

    init(centre: CGPoint, width: CGFloat, height: CGFloat, id: UUID = UUID(), rotationInRadians: CGFloat = 0) {
        self.id = id
        self.width = width
        self.height = height
        self.centre = centre
        self.rotationInRadians = rotationInRadians
        self.originalHeight = height
        self.originalWidth = width
    }

    func applyTransform() {

    }
    mutating func moveCentre(to: CGPoint) {
        centre = to
    }

    init(centre: CGPoint) {
        self.init(centre: centre, width: RectangleBlock.defaultWidth,
                  height: RectangleBlock.defaultHeight, rotationInRadians: 0)
    }

    func containsPoint(_ at: CGPoint) -> Bool {
        let xWithin = at.x <= centre.x + width / 2 && at.x >= centre.x - width / 2
        let yWithin = at.y <= centre.y + height / 2 && at.y >= centre.y - height / 2
        return xWithin && yWithin
    }

    mutating func scale(by: Float) {
        width = originalWidth * CGFloat(by)
        height = originalHeight * CGFloat(by)
    }
}

extension RectangleBlock {
    static let sampleBlock = RectangleBlock(centre: CGPoint(x: 400, y: 400))
}

extension RectangleBlock: Codable {

}
