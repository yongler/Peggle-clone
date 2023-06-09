//
//  Ball.swift
//  Peggle
//
//  Created by Lee Yong Ler on 5/2/23.
//
//
import Foundation

struct Ball {
    var centre: CGPoint
    var radius: CGFloat
    var powerUps: Set<BallPowerEnum>

    static let defaultBallRadius = CGFloat(25)

    init(centre: CGPoint, radius: CGFloat = defaultBallRadius, powerUps: Set<BallPowerEnum> = []) {
        self.centre = centre
        self.radius = radius
        self.powerUps = powerUps
    }

    mutating func moveCentre(by: CGSize) {
        centre.x += by.width
        centre.y += by.height
    }

    mutating func moveCentre(to: CGPoint) {
        centre = to
    }

    mutating func moveToTop(gameArea: CGSize) {
        centre = CGPoint(x: gameArea.width / 2, y: 100)
    }

    mutating func addPowerUp(power: BallPowerEnum) {
        powerUps.insert(power)
    }

    mutating func addPowerUps(powerUps: Set<BallPowerEnum>) {
        for power in powerUps {
            self.powerUps.insert(power)
        }
    }
}

extension Ball {
    static let sampleBall = Ball(centre: CGPoint(x: 400, y: 100), radius: Ball.defaultBallRadius)
}

extension Ball: CustomStringConvertible {
    var description: String {
        "ball \(centre) \(powerUps)"
    }
}
