//
//  MoveableObject.swift
//  Peggle
//
//  Created by Lee Yong Ler on 5/2/23.
//

import Foundation

protocol MoveableObject: Object {
    var velocity: Vector { get set }
    var acceleration: Acceleration { get set }
}
