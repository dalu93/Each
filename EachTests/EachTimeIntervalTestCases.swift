//
//  EachTimeIntervalTestCases.swift
//  Each
//
//  Created by Luca D'Alberti on 10/22/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import XCTest
@testable import Each

class EachTimeIntervalTestCases: XCTestCase {
    
    let interval: TimeInterval = 5
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testMillisecondInterval() {
        let timer = Each(interval).milliseconds()
        
        XCTAssert(timer.timeInterval == interval / 1000, "The timeInterval should be \(interval) / 1000, but it's \(timer.timeInterval!)")
    }
    
    func testSecondsInterval() {
        let timer = Each(interval).seconds()
        
        XCTAssert(timer.timeInterval == interval , "The timeInterval should be \(interval), but it's \(timer.timeInterval!)")
    }
    
    func testMinutesInterval() {
        let timer = Each(interval).minutes()
        
        XCTAssert(timer.timeInterval == interval * 60, "The timeInterval should be \(interval) * 60, but it's \(timer.timeInterval!)")
    }
    
    func testHoursInterval() {
        let timer = Each(interval).hours()
        
        XCTAssert(timer.timeInterval == interval * 3600, "The timeInterval should be \(interval) * 3600, but it's \(timer.timeInterval!)")
    }
}
