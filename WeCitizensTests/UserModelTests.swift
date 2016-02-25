//
//  UserModelTests.swift
//  WeCitizens
//
//  Created by Teng on 2/11/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import XCTest

class UserModelTests: XCTestCase {
    
    let testRegisterName = "Hihihi"
    let testRegisterEmail = "123456789@qq.com"
    
    let testLoginName = "HelloWorld"
    let testPassword = "123456"
    
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRegister() {
        if !UserModel.hasLogin() {
            UserModel.register(testRegisterName, userEmail: testRegisterEmail, password: testPassword) { (success, error) -> Void in
                XCTAssertTrue(success)
            }
        } else {
            UserModel.logout()
            UserModel.register(testRegisterName, userEmail: testRegisterEmail, password: testPassword) { (success, error) -> Void in
                XCTAssertTrue(success)
            }
        }
        
    }
    
    func testLogin() {
        if !UserModel.hasLogin() {
            UserModel.login(testLoginName, password: testPassword) { (user, error) -> Void in
                XCTAssertNil(error)
            }
        } else {
            UserModel.logout()
            UserModel.login(testLoginName, password: testPassword) { (user, error) -> Void in
                XCTAssertNil(error)
            }
        }
        
    }
    
    func testLogout() {
        if UserModel.hasLogin() {
            UserModel.logout()
            XCTAssertTrue(!UserModel.hasLogin())
        }
    }
    
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}