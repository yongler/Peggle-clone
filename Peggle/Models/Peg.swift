//
//  Peg.swift represents peggle pegs. 
//  Peggle
//
//  Created by Lee Yong Ler on 24/1/23.
//

import Foundation

struct Peg: Equatable, Identifiable {
    static let defaultPegRadius: CGFloat = 25

    var id = UUID()
    var color: PegTypeEnum
    var centre: CGPoint
    var radius: CGFloat
    var isLit = false

    mutating func lightUp() {
        guard !isLit else {
            return
        }

        isLit = true
        switch color {
        case .blue:
            color = .blueGlow
        case .orange:
            color = .orangeGlow
        case .green:
            color = .greenGlow
        default:
            return
        }
    }

    mutating func moveCentre(to: CGPoint) {
        centre = to
    }
}

extension Peg {
    static let sampleBluePeg1 = Peg(color: .blue, centre: CGPoint(x: 250, y: 500), radius: 25)
    static let sampleBluePeg2 = Peg(color: .blue, centre: CGPoint(x: 300, y: 500), radius: 25)
    static let sampleBluePeg3 = Peg(color: .blue, centre: CGPoint(x: 350, y: 500), radius: 25)
    static let sampleBluePeg4 = Peg(color: .blue, centre: CGPoint(x: 400, y: 500), radius: 25)
    static let sampleBluePeg5 = Peg(color: .blue, centre: CGPoint(x: 450, y: 500), radius: 25)
    static let sampleOrangePeg1 = Peg(color: .orange, centre: CGPoint(x: 500, y: 500), radius: 25)
    static let sampleOrangePeg2 = Peg(color: .orange, centre: CGPoint(x: 600, y: 500), radius: 25)
    static let sampleOrangePeg3 = Peg(color: .orange, centre: CGPoint(x: 550, y: 500), radius: 25)
    static let sampleOrangePeg4 = Peg(color: .orange, centre: CGPoint(x: 650, y: 500), radius: 25)
    static let sampleOrangePeg5 = Peg(color: .orange, centre: CGPoint(x: 700, y: 500), radius: 25)
}

extension Peg: CustomStringConvertible {
    var description: String {
        "peg \(centre) \(color) \(isLit)"
    }
}

extension Peg: Codable {
}
