//
//  DataModel.swift
//  WeCitizens
//
//  Created by Teng on 2/10/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import Foundation
import Parse

class DataModel {
    
    //获取指定数量的issue,test completed
    func getIssue(from beginDate: NSDate, to endDate: NSDate, block: ([PFObject]?, NSError?) -> Void) {
        
        let query = PFQuery(className:"Issue")
        query.whereKey("createdAt", greaterThan: beginDate)
        query.whereKey("createdAt", lessThanOrEqualTo: endDate)
        
        query.findObjectsInBackgroundWithBlock(block)
        
        //Block Demo
        //        query.findObjectsInBackgroundWithBlock {
        //            (objects: [PFObject]?, error: NSError?) -> Void in
        //
        //            if error == nil {
//                        // The find succeeded.
//                        print("Successfully retrieved \(objects!.count) scores.")
//                        // Do something with the found objects
//                        if let objects = objects {
//                            for object in objects {
//                                print(object.objectId)
//                            }
//                        }
//                    } else {
//                        // Log details of the failure
//                        print("Error: \(error!) \(error!.userInfo)")
//                    }
        //        }
    }
    
    func getRevert(from beginDate: NSDate, to endDate: NSDate, block: ([PFObject]?, NSError?) -> Void) {
        let query = PFQuery(className: "Revert")
        //        query.limit = 20
        query.whereKey("createdAt", greaterThan: beginDate)
        query.whereKey("createdAt", lessThanOrEqualTo: endDate)
        
        query.findObjectsInBackgroundWithBlock(block)
    }
    
    //新建Issue
    func addNewIssue(newIssue:Issue, block:PFBooleanResultBlock?) {
        let issue = PFObject(className: "Issue")
        
        issue["userName"] = newIssue.userName
        issue["userEmail"] = newIssue.userEmail
        issue["content"] = newIssue.content
        
//        issue.saveInBackgroundWithBlock(block)
        issue.saveEventually(block)
    }
    
    func addFocusNum(issueId: String) {
        let query = PFQuery(className: "Issue")
        
        query.whereKey("objectId", equalTo: issueId)
        
        do {
            let result = try query.findObjects()
            
            if !result.isEmpty {
                var currentNum = result[0].valueForKey("focusNum") as! Int
                print("current number:\(currentNum)")
                result[0].setValue(++currentNum, forKey: "focusNum")
                result[0].saveEventually()
            } else {
                print("result is empty")
            }

        } catch {
            print("there is error")
        }
    }
    
    func addNewRevert(newRevert: Revert) {
        let revert = PFObject(className: "Revert")
        
        revert["userEmail"] = newRevert.userEmail
        revert["userName"] = newRevert.userName
        revert["content"] = newRevert.content
        revert["IssueId"] = newRevert.issueId
        
        revert.saveEventually()
    }
    
    func getCityList(from start:Int, to end: Int, block: ([PFObject]?, NSError?) -> Void) {
        let query = PFQuery(className: "Cities")
        
        query.whereKey("index", greaterThanOrEqualTo: start)
        query.whereKey("index", lessThan: end)
        
        query.findObjectsInBackgroundWithBlock(block)
    }
    
    
    
    
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
//    // The find succeeded.
//    print("Successfully retrieved \(objects!.count) scores.")
//    // Do something with the found objects
//    if let objects = objects {
//    for object in objects {
//    print("OBJECT_ID:\(object.objectId)")
//    let result = object.objectForKey("content") as! String
//    print(result)
//    }
//    }
//    } else {
//    // Log details of the failure
//    print("Error: \(error!) \(error!.userInfo)")
//    }
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
    
}
