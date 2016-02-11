//
//  DataModel.swift
//  WeCitizens
//
//  Created by Teng on 2/7/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import Foundation
import Parse

class UserModel {
    
    //注册时用邮箱注册吗？直接提供明文密码，密码的加密由Parse完成，传入回调函数当Parse返回响应时执行回调函数
    //使用邮箱注册完成后Parse会给用户发验证邮件
    //注册成功后用户不需要再次登录，complete
    static func register(userName: String, userEmail: String, password: String, withCallbackFun callback: (Bool, NSError?) -> Void) {
        let user = PFUser()
        user.username = userName
        user.password = password
        user.email = userEmail
        
        user.signUpInBackgroundWithBlock(callback)
    }
    
    //用户第一次使用用户名和密码登录，completed
    static func firstLogin(userName: String, password: String, withCallbackFun callback: (PFUser?, NSError?) -> Void) {
        PFUser.logInWithUsernameInBackground(userName, password: password, block: callback)
    }
    
    //用户第二次打开应用时在后台登录，参数为登录时需要的回调函数
    static func backgroundLogin(callbackFun callback: (PFUser?, NSError?) -> Void) {
        var currentUser = PFUser.currentUser()
        PFUser.becomeInBackground("session-token-here", block: {
            (user: PFUser?, error: NSError?) -> Void in
            if error != nil {
                // The token could not be validated.
            } else {
                // The current user is now set to user.
            }
        })
    }
    
    static func logout() {
        PFUser.logOut()
    }
    
    
    
}
