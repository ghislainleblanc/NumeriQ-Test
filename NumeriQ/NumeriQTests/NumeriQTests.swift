//
//  NumeriQTests.swift
//  NumeriQTests
//
//  Created by Ghislain Leblanc on 2020-09-03.
//  Copyright © 2020 Leblanc, Ghislain. All rights reserved.
//

import XCTest
@testable import NumeriQ

class NumeriQTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAPI() throws {
        let expectation = XCTestExpectation(description: "Download news feed home page")
        NetworkManager.shared.getNewsFeed { (feed) in
            XCTAssertTrue(feed?.articles.count == 20)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10.0)
    }
}
