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
    func getVoice(queryNum: Int, queryTimes: Int, cityName:String, needStore:Bool, resultHandler: ([Voice]?, NSError?) -> Void) {
        let query = PFQuery(className:"Voice")
        query.whereKey("city", equalTo: cityName)
        query.limit = queryNum
        query.skip = queryNum * queryTimes
        
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if error == nil {
                print("Successfully retrieved \(objects!.count) voice from remote.")
                
                if let results = objects {
                    
                    if needStore {
                        PFObject.pinAllInBackground(results)
                    }
                    
                    let voice = self.convertPFObjectToVoice(results)
                    let emails = voice.map({ (tmp) -> String in
                        return tmp.userEmail
                    })
                    
                    UserModel().getUsersInfo(emails, needStore: needStore, resultHandler: { (users, userError) -> Void in
                        if let _ = userError {
                            resultHandler(voice, userError)
                        }
                        if let newUsers = users {
                            voice.forEach({ (currentVoice) -> () in
                                for user in newUsers {
                                    if user.userEmail == currentVoice.userEmail {
                                        currentVoice.user = user
                                        break
                                    }
                                }
                            })
                            resultHandler(voice, nil)
                        }
                    })
                } else {
                    resultHandler(nil, nil)
                }
            } else {
                print("Get voice from remote Error: \(error!) \(error!.userInfo)")
                resultHandler(nil, error)
            }
        }
    }
    
    func getVoice(city:String, fromLocal resultHandler: ([Voice]?, NSError?) -> Void) {
        let query = PFQuery(className: "Voice")
        query.fromLocalDatastore()
        query.whereKey("city", equalTo: city)
        
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if error == nil {
                print("Successfully retrieved \(objects!.count) voice from local")
                
                if let results = objects {
                    
                    let voice = self.convertPFObjectToVoice(results)
                    let emails = voice.map({ (tmp) -> String in
                        return tmp.userEmail
                    })
                    
                    let userModel = UserModel()
                    
                    userModel.getUsersInfo(fromLocal: emails, resultHandler: { (users, userError) -> Void in
                        if let _ = userError {
                            resultHandler(voice, userError)
                        }
                        if let newUsers = users {
                            voice.forEach({ (currentVoice) -> () in
                                for user in newUsers {
                                    if user.userEmail == currentVoice.userEmail {
                                        currentVoice.user = user
                                        break
                                    }
                                }
                            })
                            resultHandler(voice, nil)
                        } else {
                            print("get user from local fail")
                            userModel.getUsersInfo(emails, needStore: false, resultHandler: { (users, userError) -> Void in
                                if let _ = userError {
                                    resultHandler(voice, userError)
                                }
                                if let newUsers = users {
                                    voice.forEach({ (currentVoice) -> () in
                                        for user in newUsers {
                                            if user.userEmail == currentVoice.userEmail {
                                                currentVoice.user = user
                                                break
                                            }
                                        }
                                    })
                                    resultHandler(voice, nil)
                                }
                            })
                        }
                    })
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
    
    func convertPFObjectToVoice(objects: [PFObject]) -> [Voice] {
        var voice = [Voice]()
        
        for result in objects {
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
            
            let newVoice = Voice(voiceIdFromRemote: id, email: email, name: name, date: time, title: title, abstract: abstract, content: content, status: status, classify: classifyStr, focusNum: focusNum, city: city, replied: isReplied, images: imageList)
            
            voice.append(newVoice)
        }
        return voice
    }
    
    //新建Voice, code complete
    func addNewVoice(newVoice: Voice, resultHandler: (Bool, NSError?) -> Void) {
        let voice = PFObject(className: "Voice")
        
        //给voice赋值...
        voice["userName"] = newVoice.userName
        voice["userEmail"] = newVoice.userEmail
        
        voice["title"] = newVoice.title
        voice["abstract"] = newVoice.abstract
        voice["content"] = newVoice.content
        voice["status"] = newVoice.status
        voice["classify"] = newVoice.classify.rawValue
        voice["focusNum"] = newVoice.focusNum
        voice["city"] = newVoice.city
        voice["isReplied"] = newVoice.isReplied
        voice["replyId"] = newVoice.replyId
        voice["images"] = self.convertImageToPFFile(newVoice.images)
        
        voice.saveInBackgroundWithBlock { (success, error) -> Void in
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
    func addFocusNum(voiceId: String, resultHandler:(Bool, NSError?) -> Void) {
        let query = PFQuery(className: "Voice")
        
        query.whereKey("objectId", equalTo: voiceId)
        
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
    func minusFocusNum(voiceId:String, resultHandler:(Bool, NSError?) -> Void) {
        let query = PFQuery(className: "Voice")
        
        query.whereKey("objectId", equalTo: voiceId)
        
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
    func getVoice(withId voiceId:String, resultHandler: (Voice?, NSError?) -> Void) {
        let query = PFQuery(className: "Voice")
        
        query.getObjectInBackgroundWithId(voiceId) { (object, error) -> Void in
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
                    
                    let newVoice = Voice(voiceIdFromRemote: id, email: email, name: name, date: time, title: title, abstract: abstract, content: content, status: status, classify: classifyStr, focusNum: focusNum, city: city, replied: isReplied, images: imageList)
                    
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