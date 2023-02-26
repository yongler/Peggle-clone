//
//  Velocity.swift
//  Peggle
//
//  Created by Lee Yong Ler on 5/2/23.
//

import Foundation

struct Vector: Equatable {
    var origin: CGPoint
    var directionX: CGFloat
    var directionY: CGFloat

    var endPoint: CGPoint {
        let endPointX = origin.x + directionX
        let endPointY = origin.y + directionY
        return CGPoint(x: endPointX, y: endPointY)
    }

    static let zero = Vector(origin: CGPoint(), directionX: 0, directionY: 0)

    init(origin: CGPoint, directionX: CGFloat, directionY: CGFloat) {
        self.origin = origin
        self.directionX = directionX
        self.directionY = directionY
    }

    init(origin: CGPoint) {
        self.origin = origin
        self.directionX = origin.x
        self.directionY = origin.y
    }

    init(directionX: CGFloat, directionY: CGFloat) {
        self.origin = CGPoint()
        self.directionX = directionX
        self.directionY = directionY
    }

    func subtract(_ vector: Vector) -> Vector {
        Vector(origin: self.origin, directionX: self.directionX - vector.directionX,
               directionY: self.directionY - vector.directionY)
    }

    /// Gets normalized vector perpendicular to this vector
    func getNormalizedPerpendicular() -> Vector {
        let perpendicularDirectionX: CGFloat = 1
        let perpendicularDirectionY: CGFloat = -self.directionX / self.directionY

        let perpendicularVector = Vector(origin: self.origin, directionX: perpendicularDirectionX,
                                         directionY: perpendicularDirectionY)
        return perpendicularVector.normalize()
    }

    func normalize() -> Vector {
        let norm = sqrt(pow(self.directionX, 2) + pow(self.directionY, 2))
        return Vector(origin: self.origin, directionX: self.directionX / norm, directionY: self.directionY / norm)
    }

    /// Update position that has this velocity
    func update(centre: CGPoint, time: Double) -> CGPoint {
        let newCentreX = centre.x + self.directionX * CGFloat(time)
        let newCentreY = centre.y + self.directionY * CGFloat(time)

        return CGPoint(x: newCentreX, y: newCentreY)
    }

    func dotProduct(vector: Vector) -> CGFloat {
        self.directionX * vector.directionX + self.directionY * vector.directionY
    }

    func dotProduct(point: CGPoint) -> CGFloat {
        let pointVector = Vector(origin: point, directionX: point.x, directionY: point.y)
        return dotProduct(vector: pointVector)
    }
}
