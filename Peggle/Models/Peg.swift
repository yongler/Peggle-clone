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
    var pegType: PegTypeEnum
    var centre: CGPoint
    var radius: CGFloat
    var isLit = false
    var power: PegPowerEnum

    mutating func lightUp() {
        guard !isLit else {
            return
        }

        isLit = true
        switch pegType {
        case .blue:
            pegType = .blueGlow
        case .orange:
            pegType = .orangeGlow
        case .kaboom:
            pegType = .kaboomGlow
        case .spooky:
            pegType = .spookyGlow
        case .confusement:
            pegType = .confusementGlow
        case .zombie:
            pegType = .zombieGlow
        default:
            return
        }
    }
    
    init(id: UUID = UUID(), pegType: PegTypeEnum, centre: CGPoint, radius: CGFloat = Peg.defaultPegRadius, isLit: Bool = false, power: PegPowerEnum = .nopower) {
        self.id = id
        self.pegType = pegType
        self.centre = centre
        self.radius = radius
        self.isLit = isLit
        self.power = power
    }
    
    mutating func setRadius(radius: CGFloat) {
        self.radius = radius
    }
    
    mutating func flip(centreAxisXValue: CGFloat) {
        let yDistanceToCentreAxis = centreAxisXValue - centre.y
        let newY = centre.y + yDistanceToCentreAxis
        let newCentre = CGPoint(x: centre.x, y: newY)
        moveCentre(to: newCentre)
    }

    mutating func moveCentre(to: CGPoint) {
        centre = to
    }
    
    mutating func moveCentre(by: CGSize) {
        centre.x += by.width
        centre.y += by.height
    }
}

extension Peg {
    static let sampleBluePeg1 = Peg(pegType: .blue, centre: CGPoint(x: 250, y: 500), radius: 25, power: .nopower)
    static let sampleBluePeg2 = Peg(pegType: .blue, centre: CGPoint(x: 300, y: 500), radius: 25, power: .nopower)
    static let sampleBluePeg3 = Peg(pegType: .blue, centre: CGPoint(x: 350, y: 500), radius: 25, power: .nopower)
    static let sampleBluePeg4 = Peg(pegType: .blue, centre: CGPoint(x: 400, y: 500), radius: 25, power: .nopower)
    static let sampleBluePeg5 = Peg(pegType: .blue, centre: CGPoint(x: 450, y: 500), radius: 25, power: .nopower)
    static let sampleOrangePeg1 = Peg(pegType: .orange, centre: CGPoint(x: 500, y: 500), radius: 25, power: .nopower)
    static let sampleOrangePeg2 = Peg(pegType: .orange, centre: CGPoint(x: 600, y: 500), radius: 25, power: .nopower)
    static let sampleOrangePeg3 = Peg(pegType: .orange, centre: CGPoint(x: 550, y: 500), radius: 25, power: .nopower)
    static let sampleOrangePeg4 = Peg(pegType: .orange, centre: CGPoint(x: 650, y: 500), radius: 25, power: .nopower)
    static let sampleOrangePeg5 = Peg(pegType: .orange, centre: CGPoint(x: 700, y: 500), radius: 25, power: .nopower)
}

extension Peg: CustomStringConvertible {
    var description: String {
        "peg \(centre) \(pegType) \(isLit)"
    }
}

extension Peg: Codable {
}
