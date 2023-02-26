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
        let peg = Peg(pegType: .blue, centre: CGPoint(x: 100, y: 100))
    }
 }
