//
//  EachDisposerTestCases.swift
//  EachTests
//
//  Created by D'Alberti, Luca on 11/12/17.
//  Copyright © 2017 dalu93. All rights reserved.
//

@testable import Each
import XCTest

class EachDisposerTestCases: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testAddDisposable() {
        // GIVEN
        let timer = Each(1).seconds
        let disposer = EachDisposer()

        // WHEN
        disposer.add(timer)

        // THEN
        XCTAssertTrue(disposer.timers.count == 1)
    }

    func testAddDisposableTwice() {
        // GIVEN
        let timer = Each(1).seconds
        let disposer = EachDisposer()

        // WHEN
        disposer.add(timer)
        disposer.add(timer)

        // THEN
        XCTAssertTrue(disposer.timers.count == 2)
    }

    func testDispose() {
        // GIVEN
        let timer = Each(1).seconds
        let disposer = EachDisposer()
        disposer.add(timer)
        timer.perform {
            // do something
            return .continue
        }

        // WHEN
        disposer.dispose()

        // THEN
        XCTAssertTrue(timer.isStopped == true)
    }
}
