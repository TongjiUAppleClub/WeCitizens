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
        query.whereKey("cityName", equalTo: cityName)
        query.limit = queryNum
        query.skip = queryNum * queryTimes
        
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if error == nil {
                print("Successfully retrieved \(objects!.count) scores.")
                
                if let results = objects {
                    
                    var issues = [Issue]()
                    
                    for result in results {
                        let avatarFile = result.objectForKey("avatar") as! PFFile
                        let name = result.objectForKey("userName") as! String
                        let email = result.objectForKey("userEmail") as! String
                        let resume = result.objectForKey("userResume") as! String
                        
                        let time = result.objectForKey("createdAt") as! NSDate
                        let title = result.objectForKey("title") as! String
                        let abstract = result.objectForKey("abstract") as! String
                        let content = result.objectForKey("content") as! String
                        let classifyStr = result.objectForKey("classify") as! String
                        let focusNum = result.objectForKey("focusNum") as! Int
                        let city = result.objectForKey("city") as! String
                        let isReplied = result.objectForKey("isReplied") as! Bool
                        let images = result.objectForKey("images") as! NSArray
                        
                        var avatarImage:UIImage? = nil
                        do {
                            let avatarData = try avatarFile.getData()
                            avatarImage = UIImage(data: avatarData)
                        } catch {
                            print("")
                        }
                        
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
                        
                        var avatarImage:UIImage? = nil
                        
                        do {
                            let avatarData = try avatarFile.getData()
                            avatarImage = UIImage(data: avatarData)
                        } catch {
                            print("")
                        }
                        
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
    
    func convertPFFileToImage(rawFile:PFFile) -> UIImage? {
        var image:UIImage? = nil
        do {
            let imageData = try rawFile.getData()
            image = UIImage(data: imageData)
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
    
    //新建Issue, code complete
    func addNewIssue(newIssue: Issue, block: (Bool, NSError?) -> Void) {
        let issue = PFObject(className: "Issue")
        
        //给issue赋值...
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
    
    func addNewRevert(newRevert: Reply) {
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
