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
    
    //completed
    func testGetIssue() {
        testDataModel.getIssue(20, queryTimes: 0, cityName: "shanghai") { (objects, error) -> Void in
            XCTAssertNil(error)
            XCTAssertNotNil(objects)
            if nil == error {
                if let results = objects {
                    for result in results {
                        print("Issue:\(result.content)")
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
    
    //completed
    func testGetComment() {
        testDataModel.getComment(20, queryTimes: 0, issueId: "7hPxfbuamI") { (objects, error) -> Void in
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

    //there is error
    func testGetReply() {
        testDataModel.getReply(20, queryTimes: 0, cityName: "shanghai") { (objects, error) -> Void in
            XCTAssertNil(error)
            XCTAssertNotNil(objects)
            self.expectation!.fulfill()
        }
        self.waitForExpectationsWithTimeout(10.0, handler: nil)
    }
    
    func testGetCityList() {
        testDataModel.getCityList(30, queryTimes: 0) { (objects, error) -> Void in
            self.expectation!.fulfill()
            if nil == error {
                if let results = objects {
                    for result in results {
                        print("City:\(result.name)")
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
        let newIssue = Issue(issueId: "test", email: "test", name: "test", time: nil, title: "test", abstract: "tset", content: "tset", classify: "test", focusNum: nil, city: "test", replied: nil, images: [])
        
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
        let newReply = Reply(email: "test", name: "test", time: nil, issueId: "test", title: "test", content: "test", city: "test", level: nil, images: [])
        
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
