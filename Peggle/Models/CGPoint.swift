//
//  CGPoint.swift
//  Peggle
//
//  Created by Lee Yong Ler on 5/2/23.
//

import Foundation

extension CGPoint: Hashable {
  public func hash(into hasher: inout Hasher) {
    hasher.combine(x)
    hasher.combine(y)
  }
}
