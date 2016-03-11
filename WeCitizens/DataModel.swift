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
    
    //新建Issue, complete code
    func addNewIssue(newIssue: Issue, block: (Bool, NSError?) -> Void) {
        let issue = PFObject(className: "Issue")
        
        //给issue赋值
        issue["userName"] = newIssue.userName
        issue["userEmail"] = newIssue.userEmail
        issue["content"] = newIssue.content
        
        var imageArray = [PFFile]()
        
        for newImage in newIssue.images {
            let imageData = UIImageJPEGRepresentation(newImage, 0.5)
            
            if let data = imageData {
                let imageFile = PFFile(name: nil, data: data)
                imageArray.append(imageFile!)
            } else {
                let imageDataPNG = UIImagePNGRepresentation(newImage)
                if let dataPNG = imageDataPNG {
                    let imageFile = PFFile(name: nil, data: dataPNG)
                    imageArray.append(imageFile!)
                } else {
                    //图片格式非PNG或JPEG
                    print("图片格式非PNG或JPEG，给用户个提示")
                }
            }
        }
        
        issue["Images"] = imageArray
        
        issue.saveInBackgroundWithBlock { (success, error) -> Void in
            if error == nil {
                if success {
                    block(true, nil)
                } else {
                    block(false, nil)
                }
            } else {
                block(false, error)
            }
        }
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
}
