//
//  Transformable.swift
//  Peggle
//
//  Created by Lee Yong Ler on 25/2/23.
//

import Foundation

protocol Transformable {
    var transformX: CGFloat { get set}
    var transformY: CGFloat { get set}
    var transformRotation: CGFloat { get set}
}

extension Transformable {
    func applyTransform() {
        
    }
}
