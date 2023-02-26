//
//  PegTypeEnum.swift
//  Peggle
//
//  Created by Lee Yong Ler on 22/2/23.
//

import Foundation

enum PegTypeEnum: String {
    case blue
    case blueGlow
    case orange
    case orangeGlow

    case spooky
    case spookyGlow
    case kaboom
    case kaboomGlow

    case confusement
    case confusementGlow
    case zombie
    case zombieGlow
}

extension PegTypeEnum: Codable {

}
