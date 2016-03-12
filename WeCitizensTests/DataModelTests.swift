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
        
    }
    
    func testNewIssue() {
        
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
