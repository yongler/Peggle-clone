//
//  BlockPhysicsObject.swift
//  Peggle
//
//  Created by Lee Yong Ler on 25/2/23.

import Foundation

class BlockPhysicsObject: RectanglePhysicsObject {
    var block = RectangleBlock.sampleBlock

    convenience init(block: RectangleBlock) {
        self.init(centre: block.centre, width: block.width, height: block.height)
        self.block = block
    }

    func getBlock() -> RectangleBlock {
        block
    }
}
