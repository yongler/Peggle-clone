//
//  Ball.swift
//  Peggle
//
//  Created by Lee Yong Ler on 5/2/23.
//

import Foundation

struct Ball: MoveableCircleObject {
    var centre: CGPoint
    var radius: CGFloat
    var velocity: Vector
    var acceleration: Acceleration

    func getNormalAt() {
    }
}
