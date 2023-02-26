//
//  Bucket.swift
//  Peggle
//
//  Created by Lee Yong Ler on 25/2/23.
//

import Foundation

struct Bucket {
    static let defaultPosition = CGPoint(x: 300, y: 25)

    var centre: CGPoint
    let width: CGFloat = 200
    let height: CGFloat = 80

    init() {
        self.centre = CGPoint(x: 300, y: 25)
    }

    init(centre: CGPoint) {
        self.centre = centre
    }

    var rightX: CGFloat {
        centre.x + width / 2
    }
    var leftX: CGFloat {
        centre.x - width / 2
    }
    var topY: CGFloat {
        centre.y - height / 2
    }
    var bottomY: CGFloat {
        centre.y + height / 2
    }

//    func specialEffect() {
//
//    }
}
