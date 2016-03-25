//
//  UserModelTests.swift
//  WeCitizens
//
//  Created by Teng on 3/13/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import XCTest

class UserModelTests: XCTestCase {
    
    let testUserModel = UserModel()
    var expectation:XCTestExpectation? = nil
    let users = ["843018739@qq.com", "843018739@qq.com", "843018739@qq.com"]


    override func setUp() {
        super.setUp()
        
        self.expectation = self.expectationWithDescription("Handler called")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testAddResume() {
        testUserModel.addUserResume("7hPxfbuamI") { (success, error) -> Void in
            XCTAssertNil(error)
            XCTAssertTrue(success)
            self.expectation!.fulfill()
        }
        self.waitForExpectationsWithTimeout(10.0, handler: nil)
    }
    
    func testMinusResume() {
        testUserModel.minusUserResume("vETKWM6fe5") { (success, error) -> Void in
            XCTAssertNil(error)
            XCTAssertTrue(success)
            self.expectation!.fulfill()
        }
        self.waitForExpectationsWithTimeout(10.0, handler: nil)
    }
    
    func testSetAvatar() {
        
    }

    func testGetUserData() {
        testUserModel.getUsersAvatar(users) { (objects, error) -> Void in
            XCTAssertNil(error)
            if error == nil {
                XCTAssertNotNil(objects)
                if let users = objects {
                    for user in users {
                        print("User:\(user.name)")
                    }
                }
            } else {
                print("Error: \(error!) \(error!.userInfo)")
            }
            self.expectation!.fulfill()
        }
        self.waitForExpectationsWithTimeout(10.0) { (error) -> Void in
            print("Error: \(error)")
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

}
