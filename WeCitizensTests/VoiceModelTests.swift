//
//  VoiceModelTests.swift
//  WeCitizens
//
//  Created by Teng on 3/28/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import XCTest

class VoiceModelTests: XCTestCase {
    
    let testVoiceModel = VoiceModel()
    var expectation:XCTestExpectation? = nil
    
    override func setUp() {
        super.setUp()
        
        self.expectation = self.expectationWithDescription("Handler called")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetVoice() {
        testVoiceModel.getVoice(20, queryTimes: 0, cityName: "shanghai", needStore: false) { (objects, error) -> Void in
            XCTAssertNil(error)
            XCTAssertNotNil(objects)
            if nil == error {
                if let results = objects {
                    for result in results {
                        print("Voice:\(result.content)")
                    }
                } else {
                    XCTAssert(1 == 2)
                }
            } else {
                XCTAssert(1 == 2)
                print("Error: \(error!) \(error!.userInfo)")
            }
            self.expectation!.fulfill()
        }
        self.waitForExpectationsWithTimeout(10.0, handler: nil)
    }
    
    func testNewVoice() {
        let newVoice = Voice(emailFromLocal: "test", name: "tset", title: "test", abstract: "test", content: "test", classify: "教育", city: "shanghai", images: [])
        
        testVoiceModel.addNewVoice(newVoice) { (success, error) -> Void in
            self.expectation!.fulfill()
            if nil == error {
                if success {
                    print("Add new voice success!")
                } else {
                    XCTAssert(1 == 2)
                    print("Add new voice fail")
                }
            } else {
                XCTAssert(1 == 2)
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        self.waitForExpectationsWithTimeout(10.0, handler: nil)
    }
    
    func testAddFocusNum() {
        testVoiceModel.addFocusNum("BBbJK0UyKx") { (success, error) -> Void in
            self.expectation!.fulfill()
            if nil == error {
                if success {
                    print("Focus number has been add successfully!")
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
    
    func testMinusFocusNum() {
        testVoiceModel.minusFocusNum("BBbJK0UyKx") { (success, error) -> Void in
            self.expectation!.fulfill()
            if nil == error {
                if success {
                    print("Focus number has been minused successfully!")
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
    
    func testGetOneIssue() {
        testVoiceModel.getVoice("BBbJK0UyKx") { (object, error) -> Void in
            XCTAssertNil(error)
            XCTAssertNotNil(object)
            self.expectation!.fulfill()
        }
        self.waitForExpectationsWithTimeout(10.0, handler: nil)
    }
}