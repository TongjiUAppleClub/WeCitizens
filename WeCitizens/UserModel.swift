//
//  UserModel.swift
//  WeCitizens
//
//  Created by Teng on 3/10/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import Foundation
import Parse

class UserModel {
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
    func getUsersAvatar(emails:[String], resultHandler:([User]?, NSError?) -> Void) {
        PFCloud.callFunctionInBackground("getAvatars", withParameters: ["users": emails]) { (response, error) -> Void in
            if nil == error {
                let result = response as! NSDictionary
                var newUserList = [User]()
                
                let userList = result.valueForKey("users") as! NSArray
                
                for object in userList {
                    let oneUser = object as! PFObject
                    let email = oneUser["email"] as! String
                    let name = oneUser["username"] as! String
                    let resume = oneUser["resume"] as! Int
                    let avatarFile = oneUser["avatar"] as? PFFile
                    
                    let avatarImage = DataModel.convertPFFileToImage(avatarFile)
                    
                    let newUser = User(image: avatarImage, name: name, email: email, resume: resume)
                    newUserList.append(newUser)
                }
                
                resultHandler(newUserList, nil)
            } else {
                resultHandler(nil, error)
            }
        }
    }
}