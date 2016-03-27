//
//  VoiceModel.swift
//  WeCitizens
//
//  Created by Teng on 3/27/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import Foundation
import Parse

class VoiceModel: DataModel {
    //获取指定数量Voice,code completed
    func getVoice(queryNum: Int, queryTimes: Int, cityName:String, resultHandler: ([Voice]?, NSError?) -> Void) {
        let query = PFQuery(className:"Voice")
        query.whereKey("city", equalTo: cityName)
        query.limit = queryNum
        query.skip = queryNum * queryTimes
        
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if error == nil {
                print("Successfully retrieved \(objects!.count) voices.")
                
                if let results = objects {
                    
                    var issues = [Voice]()
                    
                    for result in results {
                        let name = result.objectForKey("userName") as! String
                        let email = result.objectForKey("userEmail") as! String
                        
                        let id = result.objectId!
                        let time = result.createdAt!
                        let title = result.objectForKey("title") as! String
                        let abstract = result.objectForKey("abstract") as! String
                        let content = result.objectForKey("content") as! String
                        let status = result.objectForKey("status") as! Bool
                        let classifyStr = result.objectForKey("classify") as! String
                        let focusNum = result.objectForKey("focusNum") as! Int
                        let city = result.objectForKey("city") as! String
                        let isReplied = result.objectForKey("isReplied") as! Bool
                        let images = result.objectForKey("images") as! NSArray
                        
                        let imageList = super.convertArrayToImages(images)
                        
                        let newVoice = Voice(voiceId: id, email: email, name: name, time: time, title: title, abstract: abstract, content: content, status: status, classify: classifyStr, focusNum: focusNum, city: city, replied: isReplied, images: imageList)
                        
                        issues.append(newVoice)
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
    
    //新建Voice, code complete
    func addNewIssue(newVoice: Voice, resultHandler: (Bool, NSError?) -> Void) {
        let issue = PFObject(className: "Voice")
        
        //给issue赋值...
        issue["userName"] = newVoice.userName
        issue["userEmail"] = newVoice.userEmail
        
        issue["title"] = newVoice.title
        issue["abstract"] = newVoice.abstract
        issue["content"] = newVoice.content
        issue["status"] = newVoice.status
        issue["classify"] = newVoice.classify.rawValue
        issue["focusNum"] = newVoice.focusNum
        issue["city"] = newVoice.city
        issue["isReplied"] = newVoice.isReplied
        issue["replyId"] = newVoice.replyId
        issue["images"] = self.convertImageToPFFile(newVoice.images)
        
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
    
    //为Voice增加一个关注,code complete
    func addFocusNum(issueId: String, resultHandler:(Bool, NSError?) -> Void) {
        let query = PFQuery(className: "Voice")
        
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
    
    //为Voice减少一个关注,code complete
    func minusFocusNum(issueId:String, resultHandler:(Bool, NSError?) -> Void) {
        let query = PFQuery(className: "Voice")
        
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
    
    //根据voiceId获取voice
    func getIssue(issueId:String, resultHandler: (Voice?, NSError?) -> Void) {
        let query = PFQuery(className: "Voice")
        
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
                    let status = result.objectForKey("status") as! Bool
                    let classifyStr = result.objectForKey("classify") as! String
                    let focusNum = result.objectForKey("focusNum") as! Int
                    let city = result.objectForKey("city") as! String
                    let isReplied = result.objectForKey("isReplied") as! Bool
                    
                    let images = result.objectForKey("images") as! NSArray
                    let imageList = super.convertArrayToImages(images)
                    
                    let newVoice = Voice(voiceId: id, email: email, name: name, time: time, title: title, abstract: abstract, content: content, status: status, classify: classifyStr, focusNum: focusNum, city: city, replied: isReplied, images: imageList)
                    
                    resultHandler(newVoice, nil)
                } else {
                    //没找到voice
                    resultHandler(nil, nil)
                }
            } else {
                resultHandler(nil, error)
            }
            
        }
    }
}