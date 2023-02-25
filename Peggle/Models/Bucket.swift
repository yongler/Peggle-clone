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
}
