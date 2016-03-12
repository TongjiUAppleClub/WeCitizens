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


    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        //    let dataModel = DataModel()
        //
        //    let dateStr1 = "2016-02-01"
        //    let dateStr2 = "2016-02-28"
        //
        //    let dateFormatter = NSDateFormatter()
        //    dateFormatter.dateFormat = "yyyy-MM-dd"
        //
        //    let date1 = dateFormatter.dateFromString(dateStr1)!
        //    let date2 = dateFormatter.dateFromString(dateStr2)!
        //
        //    dataModel.getRevert(from: date1, to: date2) { (objects, error) -> Void in
        //    if error == nil {
//            // The find succeeded.
//            print("Successfully retrieved \(objects!.count) scores.")
//            // Do something with the found objects
//            if let objects = objects {
//            for object in objects {
//            print("OBJECT_ID:\(object.objectId)")
//            let result = object.objectForKey("content") as! String
//            print(result)
//            }
//            }
//            } else {
//            // Log details of the failure
//            print("Error: \(error!) \(error!.userInfo)")
//            }
        //    }
        
        //        let testIssue = Issue(email: "test", name: "test", content: "test", abstract: "test")
        //
        //        dataModel.addNewIssue(testIssue) { (isSuccess, error) -> Void in
        //            if error == nil {
        //                if isSuccess {
        //                    print("success")
        //                } else {
        //                    print("fail")
        //                }
        //            } else {
        //                print("Error: \(error!) \(error!.userInfo)")
        //            }
        //        }
        
        //        dataModel.addFocusNum("q8POqWlAzy")
        
        //        let testRevert = Revert(id: "test", content: "test", email: "test", name: "test")
        //        dataModel.addNewRevert(testRevert)
        
        //    dataModel.getCityList(from: 0, to: 50) { (objects, error) -> Void in
        //    if error == nil {
        //    if let results = objects {
        //    print("city:")
        //    for result in results {
        //    let name = result.objectForKey("cityName") as! String
        //    print(name)
        //    }
        //    }
        //    }
        //    }
        
//        let model = DataModel()
//        let issue = Issue(email: "843018739@qq.com", name: "teng", title: "test0310(2)", classify: "test", content: "test", abstract: "test", images: [])
//        print("-------------------------------")
//        print(issue.userEmail)
        
        //        model.addNewIssue(issue) { (isSuccess, error) -> Void in
        //            if error == nil {
        //                if isSuccess {
        //                    print("success")
        //                } else {
        //                    print("fail")
        //                }
        //            } else {
        //                print("Error: \(error!) \(error!.userInfo)")
        //            }
        //        }
        
        
//        let dateStr1 = "2016-03-01"
//        let dateStr2 = "2016-03-28"
//        
//        let dateFormatter = NSDateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//        
//        let date1 = dateFormatter.dateFromString(dateStr1)!
//        let date2 = dateFormatter.dateFromString(dateStr2)!
//        
//        
//        //        // The find succeeded.
//        //        print("Successfully retrieved \(objects!.count) scores.")
//        //        // Do something with the found objects
//        //        if let objects = objects {
//        //            for object in objects {
//        //                print("OBJECT_ID:\(object.objectId)")
//        //                let result = object.objectForKey("content") as! String
//        //                print(result)
//        //            }
//        //        }
//        //    } else {
//        //    // Log details of the failure
//        //    print("Error: \(error!) \(error!.userInfo)")
//        //    }
//        
//        
//        model.getIssue(from: date1, to: date2) { (objects, error) -> Void in
//            if error == nil {
//                print("Successfully retrieved \(objects!.count) scores.")
//                if let objects = objects {
//                    for object in objects {
//                        print("OBJECT_ID:\(object.objectId)")
//                        if object.objectId == "tsWW9HwEJp" {
//                            let images = object.objectForKey("Images") as! NSArray
//                            for tmp in images {
//                                let imageFile = tmp as! PFFile
//                                imageFile.getDataInBackgroundWithBlock({ (imageData, error) -> Void in
//                                    if error == nil {
//                                        if let data = imageData {
//                                            let image = UIImage(data: data)
//                                            self.testAvatar = image
//                                        }
//                                    }
//                                })
//                                
//                            }
//                        }
//                        
//                    }
//                }
//            }
//        }

    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetIssue() {
        let expectation = self.expectationWithDescription("Handler called")
        testDataModel.getIssue(20, queryTimes: 0, cityName: "shanghai") { (objects, error) -> Void in
            expectation.fulfill()
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
        let expectation = self.expectationWithDescription("Handler called")
        testDataModel.getReply(20, queryTimes: 0, cityName: "shanghai") { (objects, error) -> Void in
            expectation.fulfill()
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
        
    }
    
    func testNewIssue() {
        
    }
    
    func testNewReply() {
        
    }
    
    func testGetOneIssue() {
        
    }
    
    func testGetOneReply() {
        
    }
    
    func testGetCityList() {
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

}
