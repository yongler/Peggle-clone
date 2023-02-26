//
//  PegTypeEnum.swift
//  Peggle
//
//  Created by Lee Yong Ler on 22/2/23.
//

import Foundation

enum PegTypeEnum: String {
    case blue = "peg-blue"
    case blueGlow = "peg-blue-glow"
    case orange = "peg-orange"
    case orangeGlow = "peg-orange-glow"
    
    case spooky = "peg-purple"
    case spookyGlow = "peg-purple-glow"
    case kaboom = "peg-green"
    case kaboomGlow = "peg-green-glow"
 
    case confusement = "peg-yellow"
    case confusementGlow = "peg-yellow-glow"
    case zombie = "peg-red"
    case zombieGlow = "peg-red-glow"
}


extension PegTypeEnum: Codable {
    
}
