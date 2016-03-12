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
    
    //获取指定数量issue,code completed
    func getIssue(queryNum: Int, queryTimes: Int, cityName:String, block: ([Issue]?, NSError?) -> Void) {
        let query = PFQuery(className:"Issue")
        query.whereKey("city", equalTo: cityName)
        query.limit = queryNum
        query.skip = queryNum * queryTimes
        
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if error == nil {
                print("Successfully retrieved \(objects!.count) scores.")
                
                if let results = objects {
                    
                    var issues = [Issue]()
                    
                    for result in results {
                        let avatarFile = result.objectForKey("avatar") as? PFFile
                        let name = result.objectForKey("userName") as! String
                        let email = result.objectForKey("userEmail") as! String
                        let resume = result.objectForKey("userResume") as! Int
                        
                        let time = result.createdAt!
                        let title = result.objectForKey("title") as! String
                        let abstract = result.objectForKey("abstract") as! String
                        let content = result.objectForKey("content") as! String
                        let classifyStr = result.objectForKey("classify") as! String
                        let focusNum = result.objectForKey("focusNum") as! Int
                        let city = result.objectForKey("city") as! String
                        let isReplied = result.objectForKey("isReplied") as! Bool
                        let images = result.objectForKey("images") as! NSArray
                        let avatarImage = self.convertPFFileToImage(avatarFile)
                        
                        let imageList = self.convertArrayToImages(images)
                        
                        let newIssue = Issue(avatar: avatarImage, email: email, name: name, resume: resume, time: time, title: title, abstract: abstract, content: content, classify: classifyStr, focusNum: focusNum, city: city, replied: isReplied, images: imageList)
                        
                        issues.append(newIssue)
                    }
                    block(issues, nil)
                }
            } else {
                //Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
                block(nil, error)
            }
        }
    }
    
    //获取指定数量comment,code completed
    func getComment(queryNum:Int, queryTimes:Int, issueId:String, block: ([Comment]?, NSError?) -> Void) {
        let query = PFQuery(className: "Comment")
        
        query.whereKey("issueId", equalTo: issueId)
        query.limit = queryNum
        query.skip = queryNum * queryTimes
        
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if error == nil {
                print("Successfully retrieved \(objects!.count) scores.")
                
                if let results = objects {
                    var comments:[Comment] = []
                    
                    for result in results {
                        let avatarFile = result.objectForKey("avatar") as! PFFile
                        let email = result.objectForKey("userEmail") as! String
                        let name = result.objectForKey("userName") as! String
                        
                        let time = result.objectForKey("createdAt") as! NSDate
                        let id = result.objectForKey("issueId") as! String
                        let content = result.objectForKey("content") as! String
                        
                        let avatarImage = self.convertPFFileToImage(avatarFile)
                        
                        let newComment = Comment(avatar: avatarImage, email: email, name: name, time: time, id: id, content: content)
                        
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
    
    //获取指定数量reply,code completed
    func getReply(queryNum:Int, queryTimes:Int, cityName:String, block: ([Reply]?, NSError?) -> Void) {
        let query = PFQuery(className: "Reply")
        
        query.whereKey("city", equalTo: cityName)
        query.limit = queryNum
        query.skip = queryNum * queryTimes

        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if nil == error {
                print("Successfully retrieved \(objects!.count) scores.")
                
                if let results = objects {
                    var replies = [Reply]()
                    
                    for result in results {
                        let avatarFile = result.objectForKey("avatar") as! PFFile
                        let email = result.objectForKey("userEmail") as! String
                        let name = result.objectForKey("userName") as! String
                        
                        let time = result.objectForKey("createdAt") as! NSDate
                        let id = result.objectForKey("issueId") as! String
                        let city = result.objectForKey("city") as! String
                        let content = result.objectForKey("content") as! String
                        let satisfy = result.objectForKey("sataisfyLevel") as! Satisfy
                        let images = result.objectForKey("images") as! NSArray
                        
                        let avatarImage = self.convertPFFileToImage(avatarFile)
                        let imageList = self.convertArrayToImages(images)
                        
                        let newReply = Reply(avatar: avatarImage, email: email, name: name, time: time, id: id, content: content, city: city, level: satisfy, images: imageList)
                        
                        replies.append(newReply)
                    }
                    block(replies, nil)
                } else {
                    //Log details of the failure
                    print("Error: \(error!) \(error!.userInfo)")
                    block(nil, error)
                }
            }
        }
    }
    
    func convertPFFileToImage(rawFile:PFFile?) -> UIImage? {
        var image:UIImage? = nil
        do {
            let imageData = try rawFile?.getData()
            if let data = imageData {
                image = UIImage(data: data)
            }
        } catch {
            print("")
        }
        return image
    }
    
    func convertArrayToImages(rawArray:NSArray) -> [UIImage] {
        var imageList = [UIImage]()
        for tmp in rawArray {
            let imageFile = tmp as! PFFile
            
            do {
                let imageData = try imageFile.getData()
                let image = UIImage(data: imageData)
                imageList.append(image!)
            } catch {
                print("")
            }
        }
        return imageList
    }
    
    //
    func getCityList(from start:Int, to end: Int, block: ([PFObject]?, NSError?) -> Void) {
        let query = PFQuery(className: "Cities")
        
        query.whereKey("index", greaterThanOrEqualTo: start)
        query.whereKey("index", lessThan: end)
        
        query.findObjectsInBackgroundWithBlock(block)
    }
    
    //新建Issue, code complete
    func addNewIssue(newIssue: Issue, block: (Bool, NSError?) -> Void) {
        let issue = PFObject(className: "Issue")
        
        //给issue赋值...
        if let image = newIssue.avatar {
            var imageData:NSData? = nil
            
            imageData = UIImageJPEGRepresentation(image, 0.3)
            if let _ = imageData {
                imageData = UIImagePNGRepresentation(image)
            }
            
            let imageFile = PFFile(name: nil, data: imageData!)
            issue["avatar"] = imageFile
        }
        issue["userName"] = newIssue.userName
        issue["userEmail"] = newIssue.userEmail
        
        issue["title"] = newIssue.title
        issue["abstract"] = newIssue.abstract
        issue["content"] = newIssue.content
        issue["classify"] = newIssue.classify.rawValue
        issue["focusNum"] = newIssue.focusNum
        issue["city"] = newIssue.city
        issue["isReplied"] = newIssue.isReplied
        issue["replyId"] = newIssue.replyId
        issue["images"] = self.convertImageToPFFile(newIssue.images)
        
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
    
    //增加一个关注数,code complete
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
    
    //还需要为Issue填上replyId
    func addNewReply(newReply: Reply, block: (Bool, NSError?) -> Void) {
        let reply = PFObject(className: "Reply")
        
        reply["userEmail"] = newReply.userEmail
        reply["userName"] = newReply.userName
        reply["avatar"] = newReply.avatar
        
        reply["content"] = newReply.content
        reply["issueId"] = newReply.issueId
        reply["city"] = newReply.city
        reply["satisfyLevel"] = newReply.satisfyLevel
        reply["images"] = self.convertImageToPFFile(newReply.images)
        
        reply.saveInBackgroundWithBlock { (success, error) -> Void in
            if error == nil {
                block(success, nil)
            } else {
                //Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
                block(false, error)
            }
        }
    }
    
    func convertImageToPFFile(rawImageArray:[UIImage]) -> [PFFile] {
        var imageFileArray = [PFFile]()
        
        for image in rawImageArray {
            let imageData = UIImageJPEGRepresentation(image, 0.5)
            
            if let data = imageData {
                let imageFile = PFFile(name: nil, data: data)
                imageFileArray.append(imageFile!)
            } else {
                let imageDataPNG = UIImagePNGRepresentation(image)
                if let dataPNG = imageDataPNG {
                    let imageFile = PFFile(name: nil, data: dataPNG)
                    imageFileArray.append(imageFile!)
                } else {
                    //图片格式非PNG或JPEG
                    print("图片格式非PNG或JPEG，给用户个提示")
                }
            }
        }
        
        return imageFileArray
    }
    
    func getIssue(issueId:String, resultHandler: (Issue?, NSError?) -> Void) {
        let query = PFQuery(className: "Issue")
        
        query.whereKey(issueId, equalTo: "objectId")
        
        query.getFirstObjectInBackgroundWithBlock { (object, error) -> Void in
            if nil == error {
                if let result = object {
                    let avatarFile = result.objectForKey("avatar") as? PFFile
                    let name = result.objectForKey("userName") as! String
                    let email = result.objectForKey("userEmail") as! String
                    let resume = result.objectForKey("userResume") as! Int
                    
                    let time = result.createdAt!
                    let title = result.objectForKey("title") as! String
                    let abstract = result.objectForKey("abstract") as! String
                    let content = result.objectForKey("content") as! String
                    let classifyStr = result.objectForKey("classify") as! String
                    let focusNum = result.objectForKey("focusNum") as! Int
                    let city = result.objectForKey("city") as! String
                    let isReplied = result.objectForKey("isReplied") as! Bool
                    let images = result.objectForKey("images") as! NSArray
                    let avatarImage = self.convertPFFileToImage(avatarFile)
                    
                    let imageList = self.convertArrayToImages(images)
                    
                    let newIssue = Issue(avatar: avatarImage, email: email, name: name, resume: resume, time: time, title: title, abstract: abstract, content: content, classify: classifyStr, focusNum: focusNum, city: city, replied: isReplied, images: imageList)
                    
                    resultHandler(newIssue, nil)
                } else {
                    //没找到issue
                    resultHandler(nil, nil)
                }
            } else {
                resultHandler(nil, error)
            }
        }
    }
    
    func getReply(replyId:String, resultHandler: (Reply?, NSError?) -> Void) {
        let query = PFQuery(className: "")
        
        query.whereKey("objectId", equalTo: replyId)
        
        query.getFirstObjectInBackgroundWithBlock { (object, error) -> Void in
            if nil == error {
                if let result = object {
                    let avatarFile = result.objectForKey("avatar") as! PFFile
                    let email = result.objectForKey("userEmail") as! String
                    let name = result.objectForKey("userName") as! String
                    
                    let time = result.objectForKey("createdAt") as! NSDate
                    let id = result.objectForKey("issueId") as! String
                    let city = result.objectForKey("city") as! String
                    let content = result.objectForKey("content") as! String
                    let satisfy = result.objectForKey("sataisfyLevel") as! Satisfy
                    let images = result.objectForKey("images") as! NSArray
                    
                    let avatarImage = self.convertPFFileToImage(avatarFile)
                    let imageList = self.convertArrayToImages(images)
                    
                    let newReply = Reply(avatar: avatarImage, email: email, name: name, time: time, id: id, content: content, city: city, level: satisfy, images: imageList)
                    
                    resultHandler(newReply, nil)
                } else {
                    //没找到Reply
                    resultHandler(nil, nil)
                }
            } else {
                resultHandler(nil, error)
            }
        }
    }
}
