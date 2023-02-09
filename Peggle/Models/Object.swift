//
//  Object.swift
//  Peggle
//
//  Created by Lee Yong Ler on 5/2/23.
//

import Foundation

class Object: Equatable {
    var centre: CGPoint

    init(centre: CGPoint) {
        self.centre = centre
    }

    static func ==(lhs: Object, rhs: Object) -> Bool {
        return lhs.centre == rhs.centre
    }
//    func getNormalAt(_ point: CGPoint) -> Vector

//    func projectOnto(axis: Vector) -> Vector
}
