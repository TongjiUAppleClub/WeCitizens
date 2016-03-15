//
//  DataModelTests.swift
//  WeCitizens
//
//  Created by Teng on 3/3/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import XCTest

class DataModelTests: XCTestCase {
    
    let testDataModel = DataModel()
    var expectation:XCTestExpectation? = nil


    override func setUp() {
        super.setUp()
        
        self.expectation = self.expectationWithDescription("Handler called")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetIssue() {
        testDataModel.getIssue(20, queryTimes: 0, cityName: "shanghai") { (objects, error) -> Void in
            self.expectation!.fulfill()
            if nil == error {
                if let results = objects {
                    for result in results {
                        print("ISSUE:\(result.content)")
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
    
    func testGetComment() {
        testDataModel.getComment(20, queryTimes: 0, issueId: "") { (objects, error) -> Void in
            self.expectation!.fulfill()
            if nil == error {
                if let results = objects {
                    for result in results {
                        print("ISSUE:\(result.content)")
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

    func testGetReply() {
        testDataModel.getReply(20, queryTimes: 0, cityName: "shanghai") { (objects, error) -> Void in
            self.expectation!.fulfill()
            if nil == error {
                if let results = objects {
                    for result in results {
                        print("ISSUE:\(result.content)")
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
    
    func testGetCityList() {
        testDataModel.getCityList(30, queryTimes: 0) { (objects, error) -> Void in
            self.expectation!.fulfill()
            if nil == error {
                if let results = objects {
                    for result in results {
                        print("ISSUE:\(result.name)")
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
    
    
    func testNewIssue() {
        let newIssue = Issue(avatar: nil, email: "test", name: "test", resume: nil, time: nil, title: "", abstract: "", content: "", classify: "test", focusNum: nil, city: "shanghai", replied: nil, images: [])
        
        
        testDataModel.addNewIssue(newIssue) { (success, error) -> Void in
            self.expectation!.fulfill()
            if nil == error {
                if success {
                    print("Add new issue success!")
                } else {
                    XCTAssert(1 == 2)
                    print("Add new issue fail")
                }
            } else {
                XCTAssert(1 == 2)
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        self.waitForExpectationsWithTimeout(10.0, handler: nil)
    }
    
    func testAddFocusNum() {
        testDataModel.addFocusNum("MRXRrIUVvT") { (success, error) -> Void in
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
        testDataModel.minusFocusNum("q8POqWlAzy") { (success, error) -> Void in
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
    
    func testNewReply() {
        let newReply = Reply(avatar: nil, email: "test", name: "test", time: nil, issueId: "tsWW9HwEJp", content: "testNewReply", city: "shanghai", level: nil, images: [])
        
        testDataModel.addNewReply(newReply) { (success, error) -> Void in
            XCTAssertNil(error)
            XCTAssertTrue(success)
            self.expectation!.fulfill()
        }
        self.waitForExpectationsWithTimeout(10.0, handler: nil)
    }
    
    func testGetOneIssue() {
        testDataModel.getIssue("7hPxfbuamI") { (object, error) -> Void in
            XCTAssertNil(error)
            XCTAssertNotNil(object)
            self.expectation!.fulfill()
        }
        self.waitForExpectationsWithTimeout(10.0, handler: nil)
    }
    
    func testGetOneReply() {
        testDataModel.getReply("90wzAaa94D") { (object, error) -> Void in
            XCTAssertNil(error)
            XCTAssertNotNil(object)
            self.expectation!.fulfill()
        }
        self.waitForExpectationsWithTimeout(10.0, handler: nil)
    }
    
//    func waitForGroup() {
//        var didComplete = false
//        
//        dispatch_group_notify(self.request, dispatch_get_main_queue()) { () -> Void in
//            didComplete = true
//            
//        }
//        
//        while(!didComplete) {
//            let intervar = 0.002;
//            if !NSRunLoop.currentRunLoop().runMode(NSDefaultRunLoopMode, beforeDate: NSDate(timeIntervalSinceNow: intervar)) {
//                NSThread.sleepForTimeInterval(intervar)
//            }
//        }
//    }
//
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measureBlock {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
