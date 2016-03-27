//
//  CommentModel.swift
//  WeCitizens
//
//  Created by Teng on 3/27/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import Foundation
import Parse

class CommentModel: DataModel {
    //获取指定数量comment,code completed
    func getComment(queryNum:Int, queryTimes:Int, issueId:String, block: ([Comment]?, NSError?) -> Void) {
        let query = PFQuery(className: "Comment")
        
        query.whereKey("issueId", equalTo: issueId)
        query.limit = queryNum
        query.skip = queryNum * queryTimes
        
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if error == nil {
                print("Successfully retrieved \(objects!.count) comments.")
                
                if let results = objects {
                    var comments:[Comment] = []
                    
                    for result in results {
                        let email = result.objectForKey("userEmail") as! String
                        let name = result.objectForKey("userName") as! String
                        
                        let time = result.createdAt!
                        let id = result.objectForKey("issueId") as! String
                        let content = result.objectForKey("content") as! String
                        
                        let newComment = Comment(email: email, name: name, time: time, id: id, content: content)
                        
                        comments.append(newComment)
                    }
                    
                    block(comments, nil)
                } else {
                    block(nil, error)
                }
            } else {
                //Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
                block(nil, error)
            }
        }
    }
    
    
    
    func addNewComment(newComment:Comment, resultHandler:(Bool, NSError?) -> Void) {
        let comment = PFObject(className: "Comment")
        
        //给comment赋值...
        comment["userName"] = newComment.userName
        comment["userEmail"] = newComment.userEmail
        comment["issueId"] = newComment.issueId
        comment["content"] = newComment.content
        
        
        comment.saveInBackgroundWithBlock { (success, error) -> Void in
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

}