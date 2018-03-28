//
//  PhaseTests.swift
//  PhaseTests
//
//  Created by Reiaz Gafar on 3/13/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import XCTest
@testable import Phase

class PhaseTests: XCTestCase {
    
    func testTimeAgoStr() {
        let sixSecondsAgo = Date(timeIntervalSinceNow: -6)
        let sixSecondsAgoDisplay = sixSecondsAgo.timeAgoDisplay()
        XCTAssertEqual(sixSecondsAgoDisplay, "6 seconds ago")
    }

}
