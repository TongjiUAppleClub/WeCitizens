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
}
