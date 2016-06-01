//
//  UserModel.swift
//  WeCitizens
//
//  Created by Teng on 3/10/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import Foundation
import Parse

// TODO:1.修改昵称的接口
//      2.获取用户动态的接口
//      3.增加用户动态接口
//      4.数据库修改：考虑如何添加用户关注
//      5.数据库修改：添加用户动态


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
            currentNum += 1
            result.setValue(currentNum, forKey: "resume")
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
            currentNum -= 1
            result.setValue(currentNum, forKey: "resume")
            result.saveInBackgroundWithBlock(resultHandler)
        } catch {
            print("Minus user resume error!!!!!!!!")
            resultHandler(false, nil)
        }
    }
    
    //获取用户数据
    func getUsersInfo(emails:[String], needStore:Bool, resultHandler:([User]?, NSError?) -> Void) {
        PFCloud.callFunctionInBackground("getAvatars", withParameters: ["users": emails]) { (response, error) -> Void in
            if nil == error {
                let result = response as! NSDictionary
                var newUserList = [User]()
                var pfUserList = [PFObject]()
                let userList = result.valueForKey("users") as! NSArray
                let keys = ["email", "username", "resume", "avatar", "voiceNum", "focusedNum"]
                
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
                    let focusNum = oneUser["focusedNum"] as! Int
                    
                    let newUser = User(imageFromRemote: avatarImage, name: name, email: email, resume: resume, voiceNum: voiceNum, focusedNum: focusNum)
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
            let focusNum = result["focusedNum"] as! Int

            let newUser = User(imageFromRemote: avatarImage, name: name, email: email, resume: resume, voiceNum: voiceNum, focusedNum: focusNum)
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
    
    //根据邮箱获取用户信息
    // TODO:有bug，头像为空时会crash
    func getUserInfo(email:String, resultHandler:(User?, NSError?) -> Void) {
        let query = PFUser.query()!
        
        query.whereKey("email", equalTo: email)
        query.getFirstObjectInBackgroundWithBlock { (object, error) -> Void in
            if nil == error {
                if let result = object {
                    print("user:\(result)")
//                    let avatarFile = result.valueForKey("avatar") as? PFFile//需要处理头像为空的情况
//                    let avatarImage = super.convertPFFileToImage(avatarFile)
                    let name = result.valueForKey("username") as! String
                    let email = result.valueForKey("email") as! String
                    let resume = result.valueForKey("resume") as? Int
                    let voiceNum = result.valueForKey("voiceNum") as? Int
                    let focusNum = result.valueForKey("focusedNum") as? Int
                    
                    let newUser:User
                    if let resumeNum = resume, voice = voiceNum, focus = focusNum {
                        newUser = User(imageFromRemote: nil, name: name, email: email, resume: resumeNum, voiceNum: voice, focusedNum: focus)
                    } else {
                        newUser = User(imageFromRemote: nil, name: name, email: email, resume: 100, voiceNum: 0, focusedNum: 0)
                    }
                    
                    resultHandler(newUser, nil)
                } else {
                    resultHandler(nil, nil)
                }
            } else {
                resultHandler(nil, error)
            }
        }
    }
    
    //修改用户昵称
    func modifyUserName(name:String) {
        // 需要先登录，再修改
        do {
            let user = try PFUser.logInWithUsername("my_username", password:"my_password")
            user.username = "my_new_username" // attempt to change username
            try user.save() // This succeeds, since the user was authenticated on the device

        } catch {
            
        }
    }
    
    // 获取用户的关注Voice数组
    func getFocusVoices(resultHandler: ([String]?, NSError?) -> Void) {
        let user = PFUser.currentUser()!
        let query = PFUser.query()!
        
        query.whereKey("email", equalTo: user.email!)
        query.getFirstObjectInBackgroundWithBlock { (object, error) in
            if nil == error {
                if let result = object {
                    let resultList = result.valueForKey("focusVoices") as! NSArray
                    
                    let voiceList = resultList.map({ voice -> String in
                        return (voice as! String)
                    })
                    resultHandler(voiceList, nil)
                } else {
                    resultHandler(nil, nil)
                }
            } else {
                resultHandler(nil, error)
            }
        }
    }
    
    // 给用户新增一个关注的Voice
    func addNewFocusVoice(voiceId:String, resultHandler:(Bool?, NSError?) -> Void) {
        let user = PFUser.currentUser()!
        let voiceArray = user.valueForKey("focusVoices") as! NSArray
        var voiceList = voiceArray.map { (voice) -> String in
            return (voice as! String)
        }
        voiceList.append(voiceId)
        
        user["focusVoices"] = voiceList
        user.saveInBackgroundWithBlock(resultHandler)
    }
    
    func deleteVoiceFocus(voiceId:String, resultHandler:(Bool?, NSError?) -> Void) {
        let user = PFUser.currentUser()!
        let voiceArray = user.valueForKey("focusVoices") as! NSArray
        var voiceList = voiceArray.map{ $0 as! String }
        
        // 删除voice
        for index in 0 ..< voiceList.count {
            let id = voiceList[index]
            if (id == voiceId) {
                voiceList.removeAtIndex(index)
            }
        }
        
        user["focusVoices"] = voiceList
        user.saveInBackgroundWithBlock(resultHandler)
    }
}