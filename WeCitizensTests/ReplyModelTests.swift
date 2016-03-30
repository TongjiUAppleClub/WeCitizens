//
//  ReplyModelTests.swift
//  WeCitizens
//
//  Created by Teng on 3/28/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import XCTest

class ReplyModelTests: XCTestCase {
    
    let testReplyModel = ReplyModel()
    var expectation:XCTestExpectation? = nil
    
    override func setUp() {
        super.setUp()
        
        self.expectation = self.expectationWithDescription("Reply Handler Called")
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGetReply() {
        testReplyModel.getReply(20, queryTimes: 0, cityName: "shanghai") { (objects, error) -> Void in
            XCTAssertNil(error)
            XCTAssertNotNil(objects)
            self.expectation!.fulfill()
        }
        self.waitForExpectationsWithTimeout(10.0, handler: nil)
    }
    
    //未通过
    func testNewReply() {
        let newReply = Reply(emailFromLocal: "test", name: "test", voiceId: "test", title: "test", content: "test", city: "shanghai", images: [])
        
        testReplyModel.addNewReply(newReply) { (success, error) -> Void in
            XCTAssertNil(error)
            XCTAssertTrue(success)
            self.expectation!.fulfill()
        }
        self.waitForExpectationsWithTimeout(10.0, handler: nil)
    }
    
    func testGetOneReply() {
        testReplyModel.getReply("k3lybKM8wN") { (object, error) -> Void in
            XCTAssertNil(error)
            XCTAssertNotNil(object)
            self.expectation!.fulfill()
        }
        self.waitForExpectationsWithTimeout(10.0, handler: nil)
    }
    
    func testAddSatisfication() {
        testReplyModel.addSatisfication("k3lybKM8wN", attitude: 1) { (isSuccess, error) -> Void in
            XCTAssertNil(error)
            XCTAssertTrue(isSuccess)
            self.expectation!.fulfill()
        }
        self.waitForExpectationsWithTimeout(10.0, handler: nil)
        
    }
}