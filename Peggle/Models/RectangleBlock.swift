//
//  RectangleBlock.swift
//  Peggle
//
//  Created by Lee Yong Ler on 25/2/23.
//

import Foundation

class RectangleBlock: RectangleTransformableObject, Identifiable {
    static let defaultWidth: CGFloat = 100
    static let defaultHeight: CGFloat = 80
    
    convenience init(centre: CGPoint) {
        self.init(centre: centre, width: RectangleBlock.defaultWidth, height: RectangleBlock.defaultHeight, rotationInRadians: 0)
    }
}

extension RectangleBlock {
    static let sampleBlock = RectangleBlock(centre: CGPoint(x: 300, y: 300))
}
