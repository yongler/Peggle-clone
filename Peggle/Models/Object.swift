//
//  Object.swift
//  Peggle
//
//  Created by Lee Yong Ler on 5/2/23.
//

import Foundation

protocol Object: Equatable {
    var centre: CGPoint { get set }

//    func getNormalAt(_ point: CGPoint) -> Vector

//    func projectOnto(axis: Vector) -> Vector
}
