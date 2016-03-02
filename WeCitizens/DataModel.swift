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
    
    //获取指定数量的issue
    func getIssue(from beginDate: NSDate, to endDate: NSDate, block: PFQueryArrayResultBlock?) {
        
        let query = PFQuery(className:"Issue")
        query.whereKey("createAt", greaterThan: beginDate)
        query.whereKey("createAt", lessThanOrEqualTo: endDate)
        
        query.findObjectsInBackgroundWithBlock(block)
        
        //Block Demo
        //        query.findObjectsInBackgroundWithBlock {
        //            (objects: [PFObject]?, error: NSError?) -> Void in
        //
        //            if error == nil {
        //                // The find succeeded.
        //                print("Successfully retrieved \(objects!.count) scores.")
        //                // Do something with the found objects
        //                if let objects = objects {
        //                    for object in objects {
        //                        print(object.objectId)
        //                    }
        //                }
        //            } else {
        //                // Log details of the failure
        //                print("Error: \(error!) \(error!.userInfo)")
        //            }
        //        }
    }
    
    func getRevert(from beginDate: NSDate, to endDate: NSDate, block: PFQueryArrayResultBlock?) {
        let query = PFQuery(className: "Revert")
        //        query.limit = 20
        query.whereKey("createAt", greaterThan: beginDate)
        query.whereKey("createAt", lessThanOrEqualTo: endDate)
        
        query.findObjectsInBackgroundWithBlock(block)
    }
    
    //新建Issue
    
    
}
