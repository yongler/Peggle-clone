//
//  Board+Persistence.swift
//  Peggle
//
//  Created by Lee Yong Ler on 22/2/23.
//

import Foundation

extension Board: Codable {
    enum CodingKeys: CodingKey {
        case pegs
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        pegs = try container.decode([Peg].self, forKey: .pegs)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(pegs, forKey: .pegs)
    }
}
