//
//  BoardTests.swift
//  PeggleTests
//
//  Created by Lee Yong Ler on 28/1/23.
//

import XCTest
@testable import Peggle

final class BoardTests: XCTestCase {

    func testConstruct() {
        let board = Board()

        let peg1 = Peg(color: "peg-blue", x: 300, y: 300, radius: 50)
        let peg2 = Peg(color: "peg-blue", x: 600, y: 600, radius: 50)
        let peg3 = Peg(color: "peg-orange", x: 700, y: 700, radius: 50)
        let peg4 = Peg(color: "peg-orange", x: 800, y: 800, radius: 50)

        let board1 = Board(pegs: [peg1, peg2, peg3, peg4])
    }

    func testAddPeg_colliding_pegNotAdded() {
        let board = Board()
        board.addPeg(Peg.samplePeg)

        XCTAssert(board.pegCount == 1)

        let peg1 = Peg(color: "peg-blue", x: 290, y: 290, radius: 50)
        board.addPeg(peg1)
        XCTAssert(board.pegCount == 1)
    }

    func testAddPeg() {
        let board = Board()
        board.addPeg(Peg.samplePeg)

        XCTAssert(board.pegCount == 1)
    }

    func testAddPegGivenCoordinates() {
        let board = Board()
        board.addPeg(Peg.samplePeg)

        XCTAssert(board.pegCount == 1)
    }

    func testRemovePeg() {
        let board = Board()
        let peg = Peg.samplePeg
        board.addPeg(peg)

        XCTAssert(board.pegCount == 1)

        board.removePeg(peg)
        XCTAssert(board.pegCount == 0)
    }

    func testRemovePegGivenCoordinates() {
        let board = Board()
        let peg = Peg.samplePeg
        board.addPeg(peg)

        XCTAssert(board.pegCount == 1)

        board.removePeg(x: 300, y: 300)
        XCTAssert(board.pegCount == 0)
    }

    func testClearBoard() {
        let peg1 = Peg(color: "peg-blue", x: 300, y: 300, radius: 50)
        let peg2 = Peg(color: "peg-blue", x: 600, y: 600, radius: 50)
        let peg3 = Peg(color: "peg-orange", x: 700, y: 700, radius: 50)
        let peg4 = Peg(color: "peg-orange", x: 800, y: 800, radius: 50)

        let board = Board()
        board.addPeg(peg1)
        board.addPeg(peg2)
        board.addPeg(peg3)
        board.addPeg(peg4)

        XCTAssert(board.pegCount == 4)

        board.clearBoard()
        XCTAssert(board.pegCount == 0)
    }

}
