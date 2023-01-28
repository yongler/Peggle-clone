//
//  PegTests.swift
//  PeggleTests
//
//  Created by Lee Yong Ler on 28/1/23.
//

import XCTest
@testable import Peggle

final class PegTests: XCTestCase {

    func testConstruct() {
        let peg = Peg(color: "peg-blue", x: 300, y: 300, radius: 50)
    }
}
