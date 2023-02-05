//
//  Object.swift
//  Peggle
//
//  Created by Lee Yong Ler on 5/2/23.
//

import Foundation

protocol Object {
    var centre: CGPoint { get set }

    func getNormalAt()

    func projectOnto(axis: Vector)
}
