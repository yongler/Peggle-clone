//
//  PegPowerEnum.swift
//  Peggle
//
//  Created by Lee Yong Ler on 25/2/23.
//

import Foundation

enum PegPowerEnum: Equatable {
    case kaboom
    case spookyball
    case nopower

    var kaboomRadius: CGFloat {
        200
    }
}

extension PegPowerEnum: Codable {

}
