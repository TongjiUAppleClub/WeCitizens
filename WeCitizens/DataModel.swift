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
    func getIssue(queryNum: Int, queryTimes: Int, cityName:String, resultHandler: ([Issue]?, NSError?) -> Void) {
        let query = PFQuery(className:"Issue")
        query.whereKey("city", equalTo: cityName)
        query.limit = queryNum
        query.skip = queryNum * queryTimes
        
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if error == nil {
                print("Successfully retrieved \(objects!.count) issues.")
                
                if let results = objects {
                    
                    var issues = [Issue]()
                    
                    for result in results {
                        let name = result.objectForKey("userName") as! String
                        let email = result.objectForKey("userEmail") as! String
                        
                        let id = result.objectId!
                        let time = result.createdAt!
                        let title = result.objectForKey("title") as! String
                        let abstract = result.objectForKey("abstract") as! String
                        let content = result.objectForKey("content") as! String
                        let classifyStr = result.objectForKey("classify") as! String
                        let focusNum = result.objectForKey("focusNum") as! Int
                        let city = result.objectForKey("city") as! String
                        let isReplied = result.objectForKey("isReplied") as! Bool
                        let images = result.objectForKey("images") as! NSArray
                        
                        let imageList = DataModel.convertArrayToImages(images)
                        
                        let newIssue = Issue(issueId: id, email: email, name: name, time: time, title: title, abstract: abstract, content: content, classify: classifyStr, focusNum: focusNum, city: city, replied: isReplied, images: imageList)
                        
                        issues.append(newIssue)
                    }
                    resultHandler(issues, nil)
                } else {
                    resultHandler(nil, nil)
                }
            } else {
                //Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
                resultHandler(nil, error)
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
    
    //获取指定数量reply,code completed
    func getReply(queryNum:Int, queryTimes:Int, cityName:String, resultHandler: ([Reply]?, NSError?) -> Void) {
        print("REPLY")
        let query = PFQuery(className: "Reply")
        
        query.whereKey("city", equalTo: cityName)
        query.limit = queryNum
        query.skip = queryNum * queryTimes

        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if nil == error {
                print("Successfully retrieved \(objects!.count) replies.")
                
                if let results = objects {
                    var replies = [Reply]()
                    print("SIZE:\(results.count)")
                    
                    for result in results {
                        let email = result.objectForKey("userEmail") as! String
                        let name = result.objectForKey("userName") as! String
                        
                        let time = result.createdAt!
                        let id = result.objectForKey("issueId") as! String
                        let city = result.objectForKey("city") as! String
                        let content = result.objectForKey("content") as! String
                        
                        let satisfyDictionary = result.objectForKey("satisfyLevel") as! NSDictionary
                        let level1 = satisfyDictionary.valueForKey("level1") as! Int
                        let level2 = satisfyDictionary.valueForKey("level2") as! Int
                        let level3 = satisfyDictionary.valueForKey("level3") as! Int
                        let level4 = satisfyDictionary.valueForKey("level4") as! Int
                        let satisfy = Satisfy(num1: level1, num2: level2, num3: level3, num4: level4)
                        
                        let images = result.objectForKey("images") as! NSArray
                        let imageList = DataModel.convertArrayToImages(images)
                        
                        let newReply = Reply(email: email, name: name, time: time, issueId: id, content: content, city: city, level: satisfy, images: imageList)
                        
                        replies.append(newReply)
                    }
                    print("REPLY2")
                    resultHandler(replies, nil)
                } else {
                    //Log details of the failure
                    print("Error: \(error!) \(error!.userInfo)")
                    resultHandler(nil, error)
                }
            }
        }
    }
    
    static func convertPFFileToImage(rawFile:PFFile?) -> UIImage? {
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
    
    static func convertArrayToImages(rawArray:NSArray) -> [UIImage] {
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
    func getCityList(queryNum:Int, queryTimes: Int, resultHandler: ([City]?, NSError?) -> Void) {
        let query = PFQuery(className: "Cities")
        
        query.limit = queryNum
        query.skip = queryNum * queryTimes
        
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if nil == error {
                print("Successfully retrieved \(objects!.count) cities.")
                
                if let results = objects {
                    var cities = [City]()
                    
                    for result in results {
                        let name = result.objectForKey("cityName") as! String
                        
                        let newCity = City(cityName: name)
                        
                        cities.append(newCity)
                    }
                    resultHandler(cities, nil)
                } else {
                    resultHandler(nil, nil)
                }
            } else {
                resultHandler(nil, error)
            }
        }
    }
    
    //新建Issue, code complete
    func addNewIssue(newIssue: Issue, resultHandler: (Bool, NSError?) -> Void) {
        let issue = PFObject(className: "Issue")
        
        //给issue赋值...
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
                    resultHandler(true, nil)
                } else {
                    resultHandler(false, nil)
                }
            } else {
                resultHandler(false, error)
            }
        }
    }
    
    //增加一个关注,code complete
    func addFocusNum(issueId: String, resultHandler:(Bool, NSError?) -> Void) {
        let query = PFQuery(className: "Issue")
        
        query.whereKey("objectId", equalTo: issueId)
        
        do {
            let result = try query.getFirstObject()
            
            var currentNum = result.valueForKey("focusNum") as! Int
            print("current number:\(currentNum)")
            result.setValue(++currentNum, forKey: "focusNum")
            
            result.saveInBackgroundWithBlock(resultHandler)
        } catch {
            print("there is error")
            resultHandler(false, nil)
        }
    }
    
    //减少一个关注,code complete
    func minusFocusNum(issueId:String, resultHandler:(Bool, NSError?) -> Void) {
        let query = PFQuery(className: "Issue")
        
        query.whereKey("objectId", equalTo: issueId)
        
        do {
            let result = try query.getFirstObject()
            
            var currentNum = result.valueForKey("focusNum") as! Int
            print("current number:\(currentNum)")
            result.setValue(--currentNum, forKey: "focusNum")
            
            result.saveInBackgroundWithBlock(resultHandler)
        } catch {
            print("there is error")
            resultHandler(false, nil)
        }
    }
    
    //还需要为Issue填上replyId，未完成，单元测试未通过
    func addNewReply(newReply: Reply, resultHandler: (Bool, NSError?) -> Void) {
        let reply = PFObject(className: "Reply")
        print("New Reply objectId: \(reply.objectId!)")

//        let issueQuery = PFQuery(className: "Issue")
//        issueQuery.whereKey("objectId", equalTo: issueId)
//        do {
//            let result = try issueQuery.getFirstObject()
//            result.setValue(true, forKey: "")
//            result.setValue(reply.objectId, forKey: "")
//            
//            result.saveInBackground()
//        } catch {
//            print("")
//        }
        
        
        reply["userEmail"] = newReply.userEmail
        reply["userName"] = newReply.userName
//        reply["avatar"] = newReply.avatar
        
        reply["content"] = newReply.content
        reply["issueId"] = newReply.issueId
        reply["city"] = newReply.city
        reply["satisfyLevel"] = newReply.satisfyLevel
        reply["images"] = self.convertImageToPFFile(newReply.images)
        
        reply.saveInBackgroundWithBlock { (success, error) -> Void in
            if error == nil {
                resultHandler(success, nil)
            } else {
                //Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
                resultHandler(false, error)
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
    
    //根据issueID获取issue
    func getIssue(issueId:String, resultHandler: (Issue?, NSError?) -> Void) {
        let query = PFQuery(className: "Issue")
        
        query.getObjectInBackgroundWithId(issueId) { (object, error) -> Void in
            if nil == error {
                if let result = object {
                    let name = result.objectForKey("userName") as! String
                    let email = result.objectForKey("userEmail") as! String
                    
                    let id = result.objectId!
                    let time = result.createdAt!
                    let title = result.objectForKey("title") as! String
                    let abstract = result.objectForKey("abstract") as! String
                    let content = result.objectForKey("content") as! String
                    let classifyStr = result.objectForKey("classify") as! String
                    let focusNum = result.objectForKey("focusNum") as! Int
                    let city = result.objectForKey("city") as! String
                    let isReplied = result.objectForKey("isReplied") as! Bool
                    
                    let images = result.objectForKey("images") as! NSArray
                    let imageList = DataModel.convertArrayToImages(images)
                    
                    let newIssue = Issue(issueId:id, email: email, name: name, time: time, title: title, abstract: abstract, content: content, classify: classifyStr, focusNum: focusNum, city: city, replied: isReplied, images: imageList)
                    
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
    
    //根据replyID获取reply，单元测试未通过
    func getReply(replyId:String, resultHandler: (Reply?, NSError?) -> Void) {
        let query = PFQuery(className: "Reply")
        
        query.getObjectInBackgroundWithId(replyId) { (object, error) -> Void in
            if nil == error {
                if let result = object {
//                    let avatarFile = result.objectForKey("avatar") as? PFFile
                    let email = result.objectForKey("userEmail") as! String
                    let name = result.objectForKey("userName") as! String
                    
                    let time = result.createdAt!
                    let id = result.objectForKey("issueId") as! String
                    let city = result.objectForKey("city") as! String
                    let content = result.objectForKey("content") as! String
                    
                    let satisfyDictionary = result.objectForKey("satisfyLevel") as! NSDictionary
                    let level1 = satisfyDictionary.valueForKey("level1") as! Int
                    let level2 = satisfyDictionary.valueForKey("level2") as! Int
                    let level3 = satisfyDictionary.valueForKey("level3") as! Int
                    let level4 = satisfyDictionary.valueForKey("level4") as! Int
                    let satisfy = Satisfy(num1: level1, num2: level2, num3: level3, num4: level4)
                    
                    let images = result.objectForKey("images") as! NSArray                    
                    let imageList = DataModel.convertArrayToImages(images)
                    
                    let newReply = Reply(email: email, name: name, time: time, issueId: id, content: content, city: city, level: satisfy, images: imageList)
                    
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
