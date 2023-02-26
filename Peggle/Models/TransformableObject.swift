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
}
