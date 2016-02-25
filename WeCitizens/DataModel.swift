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
    static func getIssue(from beginNum: Int, to endNum: Int, block: PFQueryArrayResultBlock?) {
        
        let query = PFQuery(className:"Issue")
        query.whereKey("numberOfIssue", greaterThan: beginNum)
        query.whereKey("numberOfIssue", lessThanOrEqualTo: endNum)
        
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
    
    static func getRevert(issueId: String, block: PFQueryArrayResultBlock?) {
        let query = PFQuery(className: "Revert")
        query.whereKey("IssueId", equalTo: issueId)
//        query.limit = 20
        
        query.findObjectsInBackgroundWithBlock(block)
    }
    
    //新建Issue
    static func addNewIssue() {
//        let testAvatar =  UIImage(named: "avatar")//头像
//        let testCommentUser = "Harold"//用户名
//        let testAbstract = "懵逼快出图！！！"//摘要
//        let testTime = "2016.2.14"//日期
//        let testBrowser = "10247"//浏览量
//        let testClassify = "Education"//分类
//        let testReputaion = "452"//回复数量
//        let testImages = [UIImage(named: "logo")!,UIImage(named: "logo")!,UIImage(named: "logo")!]//图片（数组）
        
    }
    
    
}
