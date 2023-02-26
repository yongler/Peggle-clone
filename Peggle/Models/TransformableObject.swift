//
//  TransformableObject.swift
//  Peggle
//
//  Created by Lee Yong Ler on 25/2/23.
//

import Foundation

protocol TransformableObject {
    var centre: CGPoint { get set}
    var rotationInRadians: CGFloat { get set}
//    var vertices: [CGPoint] { get }
//    var verticesAfterRotation: [CGPoint] { get }
//
//    func applyTransform()
}

extension TransformableObject {
//    var axes: [Vector] {
//        var axes = [Vector]()
//
//        for i in 0..<vertices.count {
//            let point1 = Vector(origin: vertices[i])
//            let point2 = Vector(origin: vertices[i + 1 == vertices.count ? 0 : i + 1])
//            let edge: Vector = point1.subtract(point2)
//            let normal: Vector = edge.getNormalizedPerpendicular()
//            axes.append(normal)
//        }
//        return axes
//    }
//
//    /// Project this shape onto an axis
//    func project(onto axis: Vector) -> Projection {
//        var start: CGFloat = axis.dotProduct(point: vertices[0])
//        var end: CGFloat = start
//
//        for i in 1..<vertices.count {
//            let p: CGFloat = axis.dotProduct(point: vertices[i])
//            if p < start {
//                start = p
//            } else if p > end {
//                end = p
//            }
//        }
//        return Projection(start: start, end: end)
//    }
}

//
//extension TransformableObject: Codable {
//    
//}

