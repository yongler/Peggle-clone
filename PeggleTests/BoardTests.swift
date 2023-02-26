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

        let board1 = Board(pegs: [Peg.sampleBluePeg1, Peg.sampleBluePeg2,
                                  Peg.sampleOrangePeg1, Peg.sampleOrangePeg2])
    }

    func testAddPeg_colliding_pegNotAdded() {
        var board = Board()
        board.addPeg(Peg.sampleBluePeg1)

        XCTAssert(board.pegCount == 1)

        let peg1 = Peg.sampleBluePeg1
        board.addPeg(peg1)
        XCTAssert(board.pegCount == 1)
    }

    func testAddPeg() {
        var board = Board()
        board.addPeg(Peg.sampleBluePeg1)

        XCTAssert(board.pegCount == 1)
    }

    func testAddPegGivenCoordinates() {
        var board = Board()
        board.addPeg(Peg.sampleBluePeg1)

        XCTAssert(board.pegCount == 1)
    }

    func testRemovePeg() {
        var board = Board()
        let peg = Peg.sampleBluePeg1
        board.addPeg(peg)

        XCTAssert(board.pegCount == 1)

        board.removePeg(peg)
        XCTAssert(board.pegCount == 0)
    }

    func testRemovePegGivenCoordinates() {
        var board = Board()
        let peg = Peg.sampleBluePeg1
        board.addPeg(peg)

        XCTAssert(board.pegCount == 1)

        board.removePeg(at: CGPoint(x: 250, y: 500))
        XCTAssert(board.pegCount == 0)
    }

    func testClearBoard() {
        var board = Board.sampleBoard

        XCTAssert(board.pegCount == 4)

        board.clearBoard()
        XCTAssert(board.pegCount == 0)
    }

 }
