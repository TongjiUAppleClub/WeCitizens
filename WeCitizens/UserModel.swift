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
    func userSetNewAvatar(newAvatar:UIImage, block:(Bool, NSError)) {
        
    }
    
    //增加用户信用度
    func addUserResume(userEmail:String, resultHandler:(Bool, NSError?) -> Void) {
        let query = PFQuery(className: "Issue")
        
        query.whereKey("userEmail", equalTo: userEmail)
        
//        do {
//            let results = try query.findObjects()
//            
//            for result in results {
//                result.
//            }
//            
//            var currentNum = result.valueForKey("") as! Int
//            result.setValue(++currentNum, forKey: "")
//            result.saveInBackgroundWithBlock(resultHandler)
//        } catch {
//            print("")
//            resultHandler(false, nil)
//        }
        
    }
    
    //减少用户信用度
    func minusUserResume(userEmail:String, resultHandler:(Bool, NSError?) -> Void) {
        let query = PFQuery(className: "Issue")
        
        query.whereKey("userEmail", equalTo: userEmail)
        
        do {
            let result = try query.getFirstObject()
            
            var currentNum = result.valueForKey("") as! Int
            result.setValue(--currentNum, forKey: "")
            result.saveInBackgroundWithBlock(resultHandler)
        } catch {
            print("")
            resultHandler(false, nil)
        }
    }
}