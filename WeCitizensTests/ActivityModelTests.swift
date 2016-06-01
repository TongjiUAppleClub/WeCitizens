//
//  ActivityModelTests.swift
//  WeCitizens
//
//  Created by Teng on 5/29/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import XCTest

class ActivityModelTests: XCTestCase {
    
    let testActivityModel = ActivityModel()
    var expectation:XCTestExpectation? = nil

    override func setUp() {
        super.setUp()
        self.expectation = self.expectationWithDescription("Handler called")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testNewActivity() {
        let newActivity = Activity(email: "test2", name: "test", title: "test", content: "test")
        
        testActivityModel.addNewActivity(newActivity) { (success, error) in
            self.expectation!.fulfill()
            if nil == error {
                if success {
                    print("Add new activity success!")
                } else {
                    XCTAssert(1 == 2)
                    print("Add new voactivityice fail")
                }
            } else {
                XCTAssert(1 == 2)
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        self.waitForExpectationsWithTimeout(10.0, handler: nil)
    }
    
    func testGetActivities() {
        
        testActivityModel.getUserActivitiesFromRemote(10, queryTimes: 0, userEmail: "test1") { (objects, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(objects)
            if nil == error {
                if let results = objects {
                    for result in results {
                        print("Activity:\(result.content)")
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

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

}
