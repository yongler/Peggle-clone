//
//  Projection.swift
//  Peggle
//
//  Created by Lee Yong Ler on 12/2/23.
//

import Foundation

struct Projection {
    var start: CGFloat
    var end: CGFloat

    func isOverlapping(projection: Projection) -> Bool {
        if projection.end < self.start || self.end < projection.start {
            return false
        }
        return true
    }
}
