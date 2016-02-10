//
//  DataModel.swift
//  WeCitizens
//
//  Created by Teng on 2/7/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import Foundation
import Prase

class UserModel {
    
    //注册时用邮箱注册吗？直接提供明文密码，密码的加密由Parse完成，传入回调函数当Parse返回响应时执行回调函数
    //使用邮箱注册完成后Parse会给用户发验证邮件
    //注册成功后用户不需要再次登录
    static func register(userName: String, password: String, withCallbackFun callback: (Bool, NSError?) -> Void) {
        let user = PFUesr()
        user.username = userName
        user.password = password
        
        user.signUpInBackgroundWithBlock {
            //This call will asynchronously create a new user in your Parse App.
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
                let errorString = error.userInfo?["error"] as? NSString
                // Show the errorString somewhere and let the user try again.
            } else {
                // Hooray! Let them use the app now.
            }
        }
    }
    
    //用户第一次使用用户名和密码登录
    static func firstLogin(userName: String, password: String, withCallbackFun callback: (PFUser?, NSError?) -> Void) {
        PFUser.logInWithUsernameInBackground(userName, password: password) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                // Do stuff after successful login.
            } else {
                // The login failed. Check error to see why.
            }
        }
    }
    
    //用户第二次打开应用时在后台登录，参数为登录时需要的回调函数
    static func backgroundLogin(callbackFun callback: (PFUser?, NSError?) -> Void) {
        var currentUser = PFUser.currentUser()
        PFUser.becomeInBackground("session-token-here", {
            (user: PFUser?, error: NSError?) -> Void in
            if error != nil {
                // The token could not be validated.
            } else {
                // The current user is now set to user.
            }
        })
    }
    
    static func logout() {
        PFUSer.logOut()
    }
    
    
    
}
