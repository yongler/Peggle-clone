//
//  CircleObject.swift
//  Peggle
//
//  Created by Lee Yong Ler on 5/2/23.
//

import Foundation

class CircleObject: Object {
    var radius: CGFloat
    
    init(centre: CGPoint, radius: CGFloat) {
        self.radius = radius
        super.init(centre: centre)
    }
}

//extension CircleObject {
//    func projectOnto(axis: Vector) -> Vector {
//        
//    }
//}
