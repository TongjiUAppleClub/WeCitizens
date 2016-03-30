//
//  CityModelTests.swift
//  WeCitizens
//
//  Created by Teng on 3/28/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import XCTest

class CityModelTests: XCTestCase {
    
    let testCityModel = CityModel()
    var expectation:XCTestExpectation? = nil
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGetCityList() {
//        testCityModel.getCityList(30, queryTimes: 0) { (objects, error) -> Void in
//            if nil == error {
//                if let results = objects {
//                    for result in results {
//                        print("City:\(result.name)")
//                    }
//                } else {
//                    XCTAssert(1 == 2)
//                }
//            } else {
//                XCTAssert(1 == 2)
//                print("Error: \(error!) \(error!.userInfo)")
//            }
//            self.expectation!.fulfill()
//        }
//        self.waitForExpectationsWithTimeout(10.0, handler: nil)
    }

    
    func testPerformanceExample() {
        self.measureBlock {

        }
    }
    
}
