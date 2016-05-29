//
//  ActivityModel.swift
//  WeCitizens
//
//  Created by Teng on 5/27/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import Foundation
import Parse

class ActivityModel: DataModel {
    
    func addNewActivity(newActivity: Activity, resultHandler: (Bool, NSError?) -> Void) {
        let activity = PFObject(className: "Activity")
        
        activity["title"] = newActivity.title
        activity["content"] = newActivity.content
        activity["userName"] = newActivity.userName
        activity["userEmail"] = newActivity.userEmail
        
        activity.saveInBackgroundWithBlock { (success, error) in
            if error == nil {
                if success {
                    resultHandler(true, nil)
                } else {
                    resultHandler(false, nil)
                }
            } else {
                resultHandler(false, error)
            }
        }
    }
    
    func getUserActivitiesFromRemote(queryNum: Int, queryTimes: Int, userEmail:String, resultHandler: ([Activity]?, NSError?) -> ()) {
        let query = PFQuery(className: "Activity")
        
        query.whereKey("userEmail", equalTo: userEmail)
        query.limit = queryNum
        query.skip = queryTimes
        
        query.findObjectsInBackgroundWithBlock { (objects, error) in
            if error == nil {
                print("Successfully retrieved \(objects!.count) activity from remote.")
                if let results = objects {
                    let activities = results.map({ (result) -> Activity in
                        let title = result.objectForKey("title") as! String
                        let content = result.objectForKey("content") as! String
                        
                        let email = result.objectForKey("userEmail") as! String
                        let name = result.objectForKey("userName") as! String
                        
                        let activity = Activity(email: email, name: name, title: title, content: content, date: result.createdAt!)
                        
                        return activity
                    })
                    
                    resultHandler(activities, nil)
                } else {
                    resultHandler(nil, nil)
                }
            } else {
                print("Get activity from remote Error: \(error!) \(error!.userInfo)")
                resultHandler(nil, error)
            }
        }
    }
    
    
}