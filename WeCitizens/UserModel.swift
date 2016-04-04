//
//  UserModel.swift
//  WeCitizens
//
//  Created by Teng on 3/10/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import Foundation
import Parse

class UserModel:DataModel {
    func userSetNewAvatar(newAvatar:UIImage, resultHandler:(Bool, NSError)) {
        
    }
    
    //增加用户信用度
    func addUserResume(userEmail:String, resultHandler:(Bool, NSError?) -> Void) {
        let query = PFQuery(className: "User")
        
        query.whereKey("email", equalTo: userEmail)
        
        do {
            let result = try query.getFirstObject()
            
            var currentNum = result.valueForKey("resume") as! Int
            result.setValue(++currentNum, forKey: "resume")
            result.saveInBackgroundWithBlock(resultHandler)
        } catch {
            print("Add user resume error!!!!!!!!")
            resultHandler(false, nil)
        }
    }
    
    //减少用户信用度
    func minusUserResume(userEmail:String, resultHandler:(Bool, NSError?) -> Void) {
        let query = PFQuery(className: "User")
        
        query.whereKey("email", equalTo: userEmail)
        
        do {
            let result = try query.getFirstObject()
            
            var currentNum = result.valueForKey("resume") as! Int
            result.setValue(--currentNum, forKey: "resume")
            result.saveInBackgroundWithBlock(resultHandler)
        } catch {
            print("Minus user resume error!!!!!!!!")
            resultHandler(false, nil)
        }
    }
    
    //获取用户数据
    func getUsersInfo(emails:[String], needStore:Bool, resultHandler:([User]?, NSError?) -> Void) {
//        print("USER")
//        let query = PFQuery(className: "_User")
//        
//        print("emails\(emails)")
////        query.whereKey("email", containsAllObjectsInArray: emails)
//        query.whereKey("email", containedIn: emails)
//        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
//            print("into block")
//            if nil == error {
//                print("Successfully retrieved \(objects!.count) Users.")
//                
//                if let results = objects {
//                    if needStore {
//                        PFObject.pinAllInBackground(results)
//                    }
//                    let newUserList = self.convertPFObjectToUser(results)
//                    resultHandler(newUserList, nil)
//                } else {
//                    resultHandler(nil, nil)
//                }
//            } else {
//                resultHandler(nil, error)
//            }
//
//        }
        
        
        PFCloud.callFunctionInBackground("getAvatars", withParameters: ["users": emails]) { (response, error) -> Void in
            if nil == error {
                let result = response as! NSDictionary
                var newUserList = [User]()
                var pfUserList = [PFObject]()
                let userList = result.valueForKey("users") as! NSArray
                let keys = ["email", "username", "resume", "avatar", "voiceNum", "focusNum"]
                
                for object in userList {
                    let oneUser = object as! PFObject
                    let pfUser = PFObject(className: "LocalUser", dictionary: oneUser.dictionaryWithValuesForKeys(keys))
                    pfUserList.append(pfUser)
                    
                    let email = oneUser["email"] as! String
                    let name = oneUser["username"] as! String
                    let resume = oneUser["resume"] as! Int
                    let avatarFile = oneUser["avatar"] as? PFFile
                    let avatarImage = super.convertPFFileToImage(avatarFile)
                    let voiceNum = oneUser["voiceNum"] as! Int
                    let focusNum = oneUser["focusNum"] as! Int
                    
                    let newUser = User(imageFromRemote: avatarImage, name: name, email: email, resume: resume, voiceNum: voiceNum, focusNum: focusNum)
                    newUserList.append(newUser)
                }
                if needStore {
                    PFObject.pinAllInBackground(pfUserList)
                }
                resultHandler(newUserList, nil)
            } else {
                resultHandler(nil, error)
            }
        }
    }
    
    func convertPFObjectToUser(objects:[PFObject]) -> [User] {
        var newUserList = [User]()
        
        for result in objects {
            let email = result["email"] as! String
            let name = result["username"] as! String
            let resume = result["resume"] as! Int
            let avatarFile = result["avatar"] as? PFFile
            let avatarImage = super.convertPFFileToImage(avatarFile)
            let voiceNum = result["voiceNum"] as! Int
            let focusNum = result["focusNum"] as! Int
            
            print("NAME: \(name),\(email)")
            print("what the fuck")
            
            let newUser = User(imageFromRemote: avatarImage, name: name, email: email, resume: resume, voiceNum: voiceNum, focusNum: focusNum)
            newUserList.append(newUser)
            
        }
        return newUserList
    }
    
    func getUsersInfo(fromLocal emails:[String], resultHandler:([User]?, NSError?) -> Void) {
        let query = PFQuery(className: "LocalUser")
        query.fromLocalDatastore()
        
        print("fromLocal emails:\(emails)")
        query.whereKey("email", containedIn: emails)
        
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if nil == error {
                print("Successfully retrieved \(objects!.count) Users.")
                
                if let results = objects {
                    let newUserList = self.convertPFObjectToUser(results)
                    resultHandler(newUserList, nil)
                } else {
                    resultHandler(nil, nil)
                }
            } else {
                resultHandler(nil, error)
            }
        }
    }
    
    //获取指定用户数据
    func getUserInfo(email:String, resultHandler:(User?, NSError?) -> Void) {
        let query = PFQuery(className: "User")
        
        query.whereKey("email", equalTo: email)
        query.getFirstObjectInBackgroundWithBlock { (object, error) -> Void in
            if nil == error {
                if let result = object {
                    let avatarFile = result.valueForKey("avatar") as! PFFile
                    let avatarImage = super.convertPFFileToImage(avatarFile)
                    let name = result.valueForKey("username") as! String
                    let email = result.valueForKey("email") as! String
                    let resume = result.valueForKey("resume") as! Int
                    let voiceNum = result.valueForKey("voiceNum") as! Int
                    let focusNum = result.valueForKey("focusNum") as! Int
                    
                    
                    let newUser = User(imageFromRemote: avatarImage, name: name, email: email, resume: resume, voiceNum: voiceNum, focusNum: focusNum)
                    resultHandler(newUser, nil)
                } else {
                    resultHandler(nil, nil)
                }
            } else {
                resultHandler(nil, error)
            }
        }
    }
}