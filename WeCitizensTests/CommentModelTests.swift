//
//  CommentModelTests.swift
//  WeCitizens
//
//  Created by Teng on 3/28/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import XCTest

class CommentModelTests: XCTestCase {
    
    let testCommentModel = CommentModel()
    var expectation:XCTestExpectation? = nil
    
    override func setUp() {
        super.setUp()

        self.expectation = self.expectationWithDescription("Comment Handler Called")
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGetComment() {
        testCommentModel.getComment(20, queryTimes: 0, voiceId: "k0vn8YHvXe") { (objects, error) -> Void in
            XCTAssertNil(error)
            XCTAssertNotNil(objects)
            self.expectation!.fulfill()
            if nil == error {
                if let results = objects {
                    for result in results {
                        print("Comment:\(result.content)")
                    }
                } else {
                    XCTAssert(1 == 2)
                }
            } else {
                XCTAssert(1 == 2)
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        self.waitForExpectationsWithTimeout(10.0, handler: nil)
    }
}