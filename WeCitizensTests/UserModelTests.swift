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
    let users = ["843018739@qq.com", "xudongliutjuer@163.com", "7lxd@tongji.edu.cn"]


    override func setUp() {
        super.setUp()
        
        self.expectation = self.expectationWithDescription("Handler called")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //未通过
    func testAddResume() {
        testUserModel.addUserResume("7hPxfbuamI") { (success, error) -> Void in
            XCTAssertNil(error)
            XCTAssertTrue(success)
            self.expectation!.fulfill()
        }
        self.waitForExpectationsWithTimeout(10.0, handler: nil)
    }
    
    //未通过
    func testMinusResume() {
        testUserModel.minusUserResume("vETKWM6fe5") { (success, error) -> Void in
            XCTAssertNil(error)
            XCTAssertTrue(success)
            self.expectation!.fulfill()
        }
        self.waitForExpectationsWithTimeout(10.0, handler: nil)
    }
    
    //未通过
    func testSetAvatar() {
        
    }

    func testGetUserData() {
        testUserModel.getUsersInfo(users, needStore: true) { (objects, error) -> Void in
            XCTAssertNil(error)
            if error == nil {
                XCTAssertNotNil(objects)
                if let users = objects {
                    for user in users {
                        print("Got User Info:\(user.userName)")
                    }
                }
            } else {
                print("Get User Info Error: \(error!) \(error!.userInfo)")
            }
            self.expectation!.fulfill()
        }
        self.waitForExpectationsWithTimeout(10.0, handler: nil)
    }
}
