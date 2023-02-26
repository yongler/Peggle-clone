//
//  BucketPhysicsObject.swift
//  Peggle
//
//  Created by Lee Yong Ler on 25/2/23.
//

import Foundation

class BucketPhysicsObject: RectanglePhysicsObject {
    static let defaultVelocity = Vector(directionX: 300, directionY: 0)

    convenience init(bucket: Bucket) {
        self.init(centre: bucket.centre, width: bucket.width, height: bucket.height,
                  velocity: BucketPhysicsObject.defaultVelocity, acceleration: Acceleration.zero)
    }

    func getBucket() -> Bucket {
        Bucket(centre: self.centre)
    }
}
