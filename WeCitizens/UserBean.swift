//
//  UserBean.swift
//  WeCitizens
//
//  Created by Teng on 3/15/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import Foundation
import UIKit

class User {
    var avatar:UIImage?
    var name:String
    var email:String
    var resume:Int
    var voiceNum:Int
    var focusNum:Int
    
    init(image:UIImage?, name:String, email:String, resume:Int, voiceNum:Int, focusNum:Int) {
        self.avatar = image
        self.name = name
        self.email = email
        self.resume = resume
        self.voiceNum = voiceNum
        self.focusNum = focusNum
    }
}