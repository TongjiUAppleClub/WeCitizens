//
//  DataModelTests.swift
//  WeCitizens
//
//  Created by Teng on 3/3/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import XCTest

class DataModelTests: XCTestCase {
    
    let date1Str = "2016-02-01"
    let date2Str = "2016-02-28"
    let dateFormatter = NSDateFormatter()
    var date1:NSDate!
    var date2:NSDate!
    let testDataModel = DataModel()


    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        dateFormatter.dateFormat = "yyyy-MM-dd"
        date1 = dateFormatter.dateFromString(date1Str)!
        date2 = dateFormatter.dateFromString(date2Str)!
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetIssue() {
//        XCTAssert(1 == 2, "")

        
        testDataModel.getIssue(from: date1, to: date2) { (objects, error) -> Void in
            print("It is in the closure")
            XCTAssert(1 == 2, "")

            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        print("OBJECT_ID:\(object.objectId)")
                    }
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
    
    func lala() {
        
    }

    func testGetRevert() {
//        testDataModel.getRevert(from: date1, to: date2) { (objects, error) -> Void in
//            XCTAssertNil(error, "Get!!!!!!!!!!!!!!!!!!!!")
//            if error == nil {
//                // The find succeeded.
//                print("Successfully retrieved \(objects!.count) scores.")
//                // Do something with the found objects
//                if let objects = objects {
//                    for object in objects {
////                        print(object.objectId)
//                        XCTAssert(object.objectId! == "", "get revert right!!!!!!!!!!")
//                    }
//                }
//            } else {
//                // Log details of the failure
//                print("Error: \(error!) \(error!.userInfo)")
//            }
//        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

}
